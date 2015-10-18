# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# If running bash load .bashrc
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"

    # Add arch specific bin dirs
    case "$OSTYPE" in
        linux*) os=linux;;
        darwin*) os=osx;;
    esac
    [ -d "$HOME/bin/$os" ] && PATH="$HOME/bin/$os:$PATH"
fi
