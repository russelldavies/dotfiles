# Python
[[ -d $HOME/.virtualenvs ]] || mkdir $HOME/.virtualenvs

# vim
e_header "Syncing vim bundles"
vim -u ~/.vim/bundles.vim +BundleInstall +qall || e_error "Error installing bundles"
