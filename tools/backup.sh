#!/bin/bash
# ------------------------------
# Backup and store encrypted backup in safe place.
# Author: me :)
#
# Generally, there are two approaches to backup process: full backup of all targets each time and incremental of some sort.
# When the amount (and "volume") of targets is relatively small may be it's simpler to just backup all targets and store, for example,
# three last blobs.
#
# Specials:
# BACKUP_STORE - where backup should be stored
#
# Example: ./backup.sh <target_1> <target_2>
# ------------------------------

if [[ -f "$HOME/.config/automa-sh-ion/.config" ]]; then
    # shellcheck disable=SC1090
    . "$HOME/.config/automa-sh-ion/.config"
else
    # shellcheck disable=SC1090
    . "$(pwd)/tools/libs/colors.sh"
    echo -e "${COLOR_YELLOW}Configuration file is absent, create it or setup environment${COLOR_RESET}"
    exit 1
fi

# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/colors.sh"

echo 'Start backup your data...'

# it's possible to add some targets in addition to predefined set
if [[ $# -gt 0 ]]; then
    BACKUP_LIST=("${BACKUP_LIST[@]}" "$@")
fi

current_date=$(date +%F)

rm -f "$current_date.tar.gz.gpg" # if any
tar czvpf - --exclude-vcs-ignores "${BACKUP_LIST[@]}" | gpg --symmetric --cipher-algo AES256 --s2k-digest-algo SHA512 -o "$current_date.tar.gz.gpg"
# sudo rsync --archive --acls --xattrs --verbose --delete "$current_date.tar.gz.gpg" "$BACKUP_STORE"
scp "$current_date.tar.gz.gpg" "$BACKUP_STORE"
rm -f "$current_date.tar.gz.gpg" # clear

echo -e "${COLOR_GREEN}Done.${COLOR_RESET}"

exit 0
