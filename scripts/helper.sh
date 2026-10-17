indexof() {
    local needle=$1 i=0 x; shift
    for x; do
        [[ $x == "$needle" ]] && { echo "$i"; return; }
        i=$((i + 1))
    done
    return 1
}

repeat() {
    local s=$1 n=$2 out
    printf -v out '%*s' "$n" ''
    printf '%s' "${out// /$s}"
}

setchar() {
    sed -E -i "${2}s/^(.{$3})./\1$4/" "$1"
}
