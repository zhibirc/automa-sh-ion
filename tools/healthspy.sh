#!/usr/bin/env bash
# ------------------------------
# We all are hard-working and very busy all the time. But health is required attention too! This tool tries to help us with this.
# TODO: add further explanation
# Written by Yaroslav Surilov aka zhibirc <zhibirc.echo@gmail.com> on 2021-03
########################################################################################################################

# for debug
set -o xtrace -o nounset -o pipefail

readonly BASE_DIR="$(dirname "$0")"

if [[ -f "$BASE_DIR/libs/styles.sh" ]]; then
    # shellcheck disable=SC1090
    . "$BASE_DIR/libs/styles.sh"
elif [[ -d tools && -d tools/libs ]]; then
    cd tools || { echo >&2 "Tools directory exists but I can't cd there."; exit 1; }

    . "./libs/styles.sh"
else
    echo 'Please cd into the tools before running this script.'; exit 1;
fi

readonly monitors_amount=$(xrandr | grep --count connected)

declare -i pid

if ! command -v feh >/dev/null 2>&1; then
    # feh is an X11 fast and light image viewer aimed mostly at console users
    # see https://feh.finalrewind.org/
    sudo apt update && sudo apt install feh -y
fi

# TODO: open on each monitor
# feh -F <path-to-image> &
pid=$!
sleep 3
kill $pid

exit 0
