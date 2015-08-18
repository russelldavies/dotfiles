# Debian/Ubuntu-only stuff, abort if not.
[[ -f /etc/debian_version ]] || return 1

# Update APT.
e_header "Updating APT"
sudo add-apt-repository ppa:avacariu/git-crypt
sudo apt-get -qq update
sudo apt-get -qq upgrade

# Install APT packages.
packages=(
    build-essential libssl-dev
    python python-pip python-virtualenv virtualenvwrapper python-setuptools python-dev libsqlite3-dev libreadline-dev libncurses-dev
    vim git git-extras git-crypt tmux
    tree nmap htop wget curl dnsutils bash-completion
    keychain
)

e_header "Installing APT packages: ${packages[*]}"
sudo apt-get install ${packages[*]}
