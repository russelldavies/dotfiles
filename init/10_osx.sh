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
    brew install tmux vim
    brew install ack tree lesspipe htop-osx
    brew install pyenv pyenv-virtualenv
    # OS X version is usually out of date
    brew install openssh keychain

    brew cask install karabiner seil slate flux

    # Remove outdated versions from the cellar
    brew cleanup
fi
