# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

if [[ "$(type -P brew)" ]]; then
    brew update
    brew upgrade

    e_header "Install packages"

    brew tap homebrew/dupes

    # GNU core utilities (those that come with OS X are outdated)
    brew install coreutils findutils grep bash bash-completion

    # Tools and Utils
    brew install git git-extras git-crypt
    brew install tmux
    brew install ack tree lesspipe htop-osx
    brew install reattach-to-user-namespace
    brew install python python3
    brew install openssh

    # Remove outdated versions from the cellar
    brew cleanup
fi
