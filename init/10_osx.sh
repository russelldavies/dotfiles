# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245
# TODO: remove if not an issue anymore
#if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
#    sudo xcode-select -switch /usr/bin
#fi

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
    brew install python
    brew install openssh --with-brewed-openssl --with-keychain-support

    # TODO: remove if not needed anymore
    #if [[ ! "$(type -P gcc-4.2)" ]]; then
    #    e_header "Installing Homebrew dupe recipe: apple-gcc42"
    #    brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
    #fi

    # Remove outdated versions from the cellar
    brew cleanup
fi

# Python tasks
e_header "Upgrading Python sys packages"
pip install --upgrade setuptools
pip install --upgrade pip
pip install --upgrade virtualenv virtualenvwrapper
