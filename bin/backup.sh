#!/bin/sh

if [ $# -lt 1 ]; then
    echo $0: Missing arguments
    echo usage: $0 repo
    exit 1
fi

PATH=/usr/local/bin:$PATH
eval $(keychain -q --eval --agents ssh id_ed25519 id_rsa)
export BORG_REPO=$1
export BORG_REMOTE_PATH=borg1

borg create ::'home-{utcnow:%Y-%m-%dT%H:%M:%S}' $HOME \
    -x --compression zlib \
    --exclude-caches \
    --exclude "$HOME/Applications" \
    --exclude "$HOME/Library" \
    --exclude "$HOME/Public" \
    --exclude "$HOME/.Trash" \
    ${@:2} \
  || noti -t "Borg Backup" -m "Failed to create archive"

borg prune --prefix 'home-' --keep-hourly=12 --keep-daily=7 --keep-weekly=4 --keep-monthly=6 \
  || noti -t "Borg Backup" -m "Failed to prune"
