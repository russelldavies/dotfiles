# zsh configuration

# zplug - zsh plugin manager
source ~/.zplug/init.zsh

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Plugins
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Source plugins and add commands to $PATH
zplug load

# Load the shell dotfiles, and then some:
for file in $HOME/.{exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# Python version management
eval "$(pyenv init -)"

# Launch gpg-agent with ssh agent
gpg-connect-agent /bye

# Point the SSH_AUTH_SOCK to the one handled by gpg-agent
if [ -S $HOME/.gnupg/S.gpg-agent.ssh ]; then
  export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
else
  echo "$HOME/.gnupg/S.gpg-agent.ssh doesn't exist. Is gpg-agent running ?"
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
