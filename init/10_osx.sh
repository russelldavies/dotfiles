# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

homebrew='https://raw.github.com/mxcl/homebrew/go'

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245
if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
    sudo xcode-select -switch /usr/bin
fi

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    e_header "Installing Homebrew"
    true | /usr/bin/ruby -e "$(/usr/bin/curl -fsSL $homebrew)"
fi

if [[ "$(type -P brew)" ]]; then
    # Make sure we’re using the latest Homebrew
    brew update
    # Upgrade any already-installed formulae
    brew upgrade

    e_header "Install packages"
    # Install GNU core utilities (those that come with OS X are outdated)
    brew install coreutils
    echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
    brew install findutils
    # Install Bash 4
    brew install bash

    # Install wget with IRI support
    brew install wget --enable-iri

    # Install more recent versions of some OS X tools
    brew tap homebrew/dupes
    brew install homebrew/dupes/grep

    # Tools
    brew install tmux
    brew install ack
    brew install git
    brew install git-extras
    brew install tree
    brew install lesspipe
    brew install htop-osx
    brew install reattach-to-user-namespace

    # Python
    brew install python --framework

    if [[ ! "$(type -P gcc-4.2)" ]]; then
        e_header "Installing Homebrew dupe recipe: apple-gcc42"
        brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
    fi

    # Remove outdated versions from the cellar
    brew cleanup
fi
