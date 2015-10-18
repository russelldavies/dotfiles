# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load the shell dotfiles, and then some:
for file in ~/.{exports,aliases,functions}; do
	[ -r "$file" ] && . "$file"
done
unset file

# All terminal emulators I use support 256 colors but don't advertise so
# manually set term capabilities; bad but so are crappy terms
TERM=xterm-256color

# Simple prompt
PS1='\w$ '

# Append to the history file, don't overwrite it
shopt -s histappend
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

#set bell-style visible

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
[ $(type -P brew) ] && [ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

# if git bash-completion has loaded set prompt to use git status features
if [ $(type -t __git_ps1) ]; then
    export GIT_PS1_SHOWDIRTYSTATE=yes
    export GIT_PS1_SHOWSTASHSTATE=yes
    export GIT_PS1_SHOWUNTRACKEDFILES=yes
    export GIT_PS1_SHOWUPSTREAM="auto"
    PS1='\w\[\033[0;34m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi

# Enable prompt color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

[ $(which keychain) ] && eval $(keychain -q --eval --agents ssh id_rsa)

[ $(type -P pyenv) ] && eval "$(pyenv init -)"
[ $(type -P pyenv-virtualenv-init) ] && eval "$(pyenv virtualenv-init -)"
