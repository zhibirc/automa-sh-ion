#!/bin/bash -e
# ------------------------------
# Scan target environment and find a network device by given MAC address.
# Author: me :)
# ------------------------------

# for debug
set -o xtrace

# use MAC address as an argument to find corresponding IP
ip neighbor | grep "$@" | cut -d" " -f1


