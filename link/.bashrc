# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{path,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

# All terminal emulators I use support 256 colors but don't advertise so
# manually set term capabilities; bad but so are crappy terms
TERM=xterm-256color

# Simple prompt
PS1='\w$ '

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# bash-completion on OS X via homebrew
[[ $(type -P brew) ]] && [ -f $(brew --prefix)/etc/bash_completion ] && source $(brew --prefix)/etc/bash_completion

# if git bash-completion has loaded set prompt to use git status features
if type __git_ps1 >/dev/null 2>&1; then
    export GIT_PS1_SHOWDIRTYSTATE=yes
    export GIT_PS1_SHOWSTASHSTATE=yes
    export GIT_PS1_SHOWUNTRACKEDFILES=yes
    export GIT_PS1_SHOWUPSTREAM="auto"
    PS1='\w\[\033[0;34m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi

# enable prompt color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -x /usr/bin/keychain ]; then
    eval $(keychain -q --eval --agents ssh id_rsa)
fi
