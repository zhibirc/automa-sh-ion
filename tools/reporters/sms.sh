#!/usr/bin/env bash
# ------------------------------
# Send SMS report with given address and message.
########################################################################################################################

# for debug
set -o xtrace

declare telephone="$1"
declare message="$2"

if [[ -n "$telephone" && -n "$message" ]]; then
    curl -X POST https://textbelt.com/text --data-urlencode phone="$telephone" --data-urlencode message="$message" -d key=textbelt
    exit $?
fi

exit 1
