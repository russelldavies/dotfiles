# Debian/Ubuntu-only stuff, abort if not. 
[[ -f /etc/debian_version ]] || return 1

# Update APT.
e_header "Updating APT"
sudo apt-get -qq update
sudo apt-get -qq upgrade

# Install APT packages.
packages=(
    build-essential libssl-dev
    python python-setuptools python-dev libsqlite3-dev libreadline-dev libncurses-dev
    vim git tmux
    tree nmap htop wget curl dnsutils
)

list=()
for package in "${packages[@]}"; do
    # If package is not installed add to list
    [[ $(dpkg -l "$package" 2>/dev/null) ]] || list=("${list[@]}" "$package")
done

if (( ${#list[@]} > 0 )); then
    e_header "Installing APT packages: ${list[*]}"
    for package in "${list[@]}"; do
        sudo apt-get -qq install "$package"
    done
fi

## Install Git Extras
#if [[ ! "$(type -P git-extras)" ]]; then
#  e_header "Installing Git Extras"
#  (
#    cd ~/.dotfiles/libs/git-extras &&
    #    sudo make install
#  )
#fi
