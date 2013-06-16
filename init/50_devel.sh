# Python
[[ $(type -P pip) ]] || sudo easy_install pip

packages=(
	virtualenv virtualenvwrapper
)
list=()
for package in "${packages[@]}"; do
    # If package is not installed add to list
    [[ $(pip show "$package") ]] || list=("${list[@]}" "$package")
done
if (( ${#list[@]} > 0 )); then
    e_header "Installing pip packages: ${list[*]}"
    sudo pip -q install -U ${list[*]}
fi

[[ -d $HOME/.virtualenvs ]] || mkdir $HOME/.virtualenvs

# vim
e_header "Syncing vim bundles"
vim -u ~/.vim/bundles.vim +BundleInstall +qall || e_error "Error installing bundles"
