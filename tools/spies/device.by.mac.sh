#!/bin/bash -e
# ------------------------------
# Scan target environment and find a network device by given MAC address.
# Author: me :)
# ------------------------------

# for debug
set -o xtrace

if [[ -z "$*" ]]; then
    exit 1
fi

for mac in "$@"; do
    # use MAC address as an argument to find corresponding IP
    ip neighbor | grep "$mac" | cut -d" " -f1
done

exit $?


