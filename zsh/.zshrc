# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/valerius/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
eval "$(starship init zsh)"

# Set up key bindings
bindkey '^H' backward-kill-word
bindkey ';5D' backward-word
bindkey ';5C' forward-word

# Enable plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set XDG Base Directory Environment Variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Set application-specific environment variables using XDG Base Directory paths
export BUN_INSTALL="$XDG_DATA_HOME"/bun
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export COPILOT_HOME="$XDG_CONFIG_HOME"/copilot
export npm_config_cache="$XDG_CACHE_HOME/npm"
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# Set PATH variables 
export PATH="$PATH
:/home/valerius/.local/bin
:/home/valerius/dotfiles/scripts"

# Custom Alias Commands
a() {
    local command="$1"
    shift

    case "$command" in
        "pc")
            echo "Select conventional commit type:"
            choice=$(gum choose "feat" "fix" "docs" "style" "refactor" "test" "chore")
            if [ -z "$choice" ]; then
                echo "No commit type selected. Aborted."
                return 1
            fi

            scope=$(gum input --placeholder "Scope (optional, press enter to skip)")

            msg=$(gum input --placeholder "Commit message")
            if [ -z "$msg" ]; then
                echo "Commit message cannot be empty."
                return 1
            fi

            if [ -n "$scope" ]; then
                full_msg="$choice($scope): $msg"
            else
                full_msg="$choice: $msg"
            fi

            echo "Committing with message: $full_msg"
            git add . && git commit -m "$full_msg" && git push
            ;;
        *)
            echo "Unknown command: $command"
            return 1
            ;;
    esac
}

LAST_REPO=""

cd() {
    builtin cd "$@"
    git rev-parse 2>/dev/null

    if [ $? -eq 0 ]; then
        if [ "$LAST_REPO" != $(basename $(git rev-parse --show-toplevel)) ]; then
            onefetch
            LAST_REPO=$(basename $(git rev-parse --show-toplevel))
        fi
    fi
}

alias ls='eza'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias lt='eza --tree --icons'

alias cat='bat'

alias eject-usb='read -p "Device (e.g. sdb): " dev && udisksctl unmount -b /dev/${dev}1 && udisksctl power-off -b /dev/${dev}'

# Run on startup
fastfetch
echo ""
onefetch 2>/dev/null
