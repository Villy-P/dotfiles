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
            echo -n "Commit message: "
            read msg
            if [ -z "$msg" ]; then
                echo "Commit message cannot be empty."
                return 1
            fi
            git add . && git commit -m "$choice $msg" && git push
            ;;
        *)
            echo "Unknown command: $command"
            return 1
            ;;
    esac
}

# Run on startup
fastfetch
