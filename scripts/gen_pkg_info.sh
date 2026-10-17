#!/bin/bash
set -euo pipefail

systems=(archlinux)
INITIAL_COLUMNS="archlinux" 

printf "Select a system to generate package info for:\n"
SYSTEM_PKG=$(gum choose "${systems[@]}")
printf "Generating package information...\n"

PACKAGE_DIR="$HOME/dotfiles/packages/$SYSTEM_PKG"
PACKAGE_MASTER="$HOME/dotfiles/packages/master.pkgs"

mkdir -p "$PACKAGE_DIR"
touch "$PACKAGE_MASTER"

rm_specific() {
    grep -vE "nvidia|ucode" || true
}

PACMAN_PACKAGES=$( (pacman -Qqen || true) | rm_specific)
AUR_PACKAGES=$( (pacman -Qqem || true) | rm_specific)
if command -v pipx >/dev/null; then
    PIPX_PACKAGES=$( (pipx list --short || true) | awk '{print $1}' | rm_specific)
else
    PIPX_PACKAGES=""
fi

printf '%s\n' "$PACMAN_PACKAGES" >"$PACKAGE_DIR/pacman.txt"
printf '%s\n' "$AUR_PACKAGES" >"$PACKAGE_DIR/aur.txt"
printf '%s\n' "$PIPX_PACKAGES" >"$PACKAGE_DIR/pipx.txt"

header=$(sed -n '/^# columns:/{s/^# columns: *//p;q}' "$PACKAGE_MASTER")
read -ra cols <<<"${header:-$INITIAL_COLUMNS}"

idx=-1
for i in "${!cols[@]}"; do
    if [[ ${cols[i]} == "$SYSTEM_PKG" ]]; then idx=$i; fi
done

widen=0
if ((idx < 0)); then
    idx=${#cols[@]}
    cols+=("$SYSTEM_PKG")
    widen=1
fi

flag=${SYSTEM_PKG:0:1}
for c in "${cols[@]}"; do
    if [[ $c != "$SYSTEM_PKG" && ${c:0:1} == "$flag" ]]; then
        printf 'warning: "%s" and "%s" share the flag "%s"\n' "$c" "$SYSTEM_PKG" "$flag" >&2
    fi
done

legend=""
for c in "${cols[@]}"; do legend+="${c:0:1} = $c   "; done
legend+="- = not installed"

tmp="$PACKAGE_MASTER.tmp"
awk -v cols="${cols[*]}" -v ncols="${#cols[@]}" -v idx="$idx" \
    -v ch="$flag" -v widen="$widen" -v legend="$legend" '
    # file 1: installed packages
    NR == FNR {
        if ($1 != "" && !($1 in installed)) { installed[$1] = 1; order[++m] = $1 }
        next
    }
    /^# (columns|legend):/ { next }           # rewritten at the end
    /^##/ {
        n++; kind[n] = 2; title[n] = $2; cursec++
        if ($2 == "unsorted") hasuns = 1
        next
    }
    /^\[/ {
        n++; kind[n] = 1
        flags = $1; gsub(/[][]/, "", flags)
        name = $2
        desc = $0; sub(/^\[[^]]*\][ \t]+[^ \t]+[ \t]*/, "", desc)
        if (widen) flags = flags "-"
        flags = substr(flags, 1, idx) ((name in installed) ? ch : "-") substr(flags, idx + 2)
        seen[name] = 1; F[n] = flags; N[n] = name; D[n] = desc
        S[n] = cursec
        if (length(name) > sw[cursec]) sw[cursec] = length(name)
        if (length(name) > gw) gw = length(name)
        if (length(desc) > dw) dw = length(desc)
        next
    }
    { n++; kind[n] = 0; raw[n] = $0 }         # blanks, comments, anything else
    END {
        # packages not in the master yet go under [unsorted] (keep it last)
        added = 0
        for (j = 1; j <= m; j++) {
            p = order[j]
            if (p in seen) continue
            if (!added) {
                if (!hasuns) {
                    n++; kind[n] = 0; raw[n] = ""
                    n++; kind[n] = 2; title[n] = "unsorted"; cursec++
                }
                added = 1
            }
            fl = ""
            for (k = 0; k < ncols; k++) fl = fl (k == idx ? ch : "-")
            n++; kind[n] = 1; F[n] = fl; N[n] = p; D[n] = "nodesc"
            S[n] = cursec
            if (length(p) > sw[cursec]) sw[cursec] = length(p)
            if (length(p) > gw) gw = length(p)
        }
        if (dw < 6) dw = 6
        total = ncols + 3 + gw + 2 + dw

        print "# columns: " cols
        print "# legend:  " legend
        for (i = 1; i <= n; i++) {
            if (kind[i] == 0) print raw[i]
            else if (kind[i] == 2) {
                line = "## " title[i] " "
                while (length(line) < total) line = line "-"
                print line
            } else printf "[%s] %-*s  %s\n", F[i], sw[S[i]], N[i], D[i]
        }
    }
' <(printf '%s\n' "$PACMAN_PACKAGES" "$AUR_PACKAGES" "$PIPX_PACKAGES") \
    "$PACKAGE_MASTER" >"$tmp" && mv "$tmp" "$PACKAGE_MASTER"

systemctl list-units --type=service --state=running --no-legend |
    awk '{print $1}' >"$PACKAGE_DIR/services.txt"
