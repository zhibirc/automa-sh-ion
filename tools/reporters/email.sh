#!/bin/bash -e
# ------------------------------
# Send Email report with given address and message.
# Author: me :)
# ------------------------------

# for debug
set -o xtrace

readonly subject="Report from $(hostname)"

declare email="$1"
declare message="$2"

echo "$message" | mail -s "$subject" "$email"

exit $?
