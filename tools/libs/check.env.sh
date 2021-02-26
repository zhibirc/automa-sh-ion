#!/bin/bash -e
# ------------------------------
# Set of common system environment checks. Usually required as preparation for further work.
# Written by Yaroslav Surilov aka zhibirc <zhibirc.echo@gmail.com> on 2021-03
# ------------------------------

# for debug
set -o xtrace -o nounset -o pipefail


# Bash version check
bash () {
    local -r BASE_VERSION=4

    if [[ "${BASH_VERSINFO[0]}" -lt "${1:-$BASE_VERSION}" ]]; then
        echo "Looks like you're running an older version of Bash."
        echo "You need at least bash-4.0 or some options will not work correctly."

        exit 1
    fi

    exit 0
}
