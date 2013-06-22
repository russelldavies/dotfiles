# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"

    # Add arch specific bin dirs
    case "$OSTYPE" in
        linux*)
            os=linux
            ;;
        darwin*)
            os=osx
            ;;
    esac
    if [ -d "$HOME/bin/$os" ] ; then
        PATH="$HOME/bin/$os:$PATH"
    fi
fi

if [ -d "$HOME/usr/bin" ] ; then
    PATH="$HOME/usr/bin:$PATH"
fi
