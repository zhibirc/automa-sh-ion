#!/usr/bin/env bash

set -o xtrace

declare telephone="$1"
declare message="$2"

# TODO: check for unknown login attempt or other suspicious things
# use snort, analyze auth.log, etc.

if [[ -n "$telephone" && -n "$message" ]]; then
    curl -X POST https://textbelt.com/text --data-urlencode phone="$telephone" --data-urlencode message="$message" -d key=textbelt
fi

exit 0
