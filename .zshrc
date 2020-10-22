# zplug - zsh plugin manager
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

zstyle ':completion:*' rehash true

# Load the shell dotfiles, and then some:
for file in $HOME/.{exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# vim mode
bindkey -v
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
export KEYTIMEOUT=1

# YubiKey PIV SSH
export SSH_AUTH_SOCK="/usr/local/var/run/yubikey-agent.sock"

# direnv
eval "$(direnv hook zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
