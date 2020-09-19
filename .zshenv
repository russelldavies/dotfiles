PATH=$HOME/bin:$PATH
PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
PATH=node_modules/.bin:$PATH
PATH="/usr/local/sbin:$PATH"
if [ -e /Users/russell/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/russell/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
