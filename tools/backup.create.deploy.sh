#!/usr/bin/env bash

# predefine some custom set to backup, use it if no arguments
# exclude all that excluded in Git (looks for .gitignore)
# work with all given list of files and folders
# use strong hash algorithms from GnuPG
# add name for archive as a date it was created

echo 'Start backup your data...'

USER_NAME='yaroslav'
BACKUP_DESTINATION="$USER_NAME@10.11.12.13:/home/$USER_NAME/backup"
BACKUP_DEFAULTS="$HOME/Music"

backup_set=$@
current_date=$(date +%F)

if [[ $# == 0 ]]; then
    echo "0 files given to backup, default set will be used"

    backup_set=$BACKUP_DEFAULTS
fi

rm -f "$current_date.tar.gz.gpg" # if any
tar czvpf - --exclude-vcs-ignores $backup_set | gpg --symmetric --cipher-algo AES256 --s2k-digest-algo SHA512 -o "$current_date.tar.gz.gpg"
# sudo rsync --archive --acls --xattrs --verbose --delete "$current_date.tar.gz.gpg" "$BACKUP_DESTINATION"
scp "$current_date.tar.gz.gpg" $BACKUP_DESTINATION
rm -f "$current_date.tar.gz.gpg" # clear

echo "All is done, don't forget to do this regularly!"

exit 0
