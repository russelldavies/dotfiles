# This file is sourced at the end of a first-time dotfiles install.
shopt -s expand_aliases
source ~/.profile

# git-crypt
e_header "git-crypt"
echo "Compiling..."
make -sC lib/git-crypt || e_error "git-crypt didn't compile successfully"
if [[ $(type -p $HOME/bin/git-crypt) ]]; then
    read -e -p "Enter absolute path to git-crypt keyfile: " git_keyfile
    if [[ -f "$git_keyfile" ]]; then
        $HOME/bin/git-crypt init "$git_keyfile"
        echo "Decrypted successfully"
    else
        echo "The file you specified did not exist, decryption failed"
    fi
else
    e_error "git-crypt wasn't found, manually init is necessary"
fi

# setup remote of this repo to use pubkey auth
(cd ~/.dotfiles/ && git remote set-url origin git@github.com:russelldavies/dotfiles.git)

# Reminder message
e_header "First-Time Reminders"
cat <<EOF
None yet...
EOF
