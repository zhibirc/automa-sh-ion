#!/bin/bash
# ------------------------------
# Lightweight brute-force for access to not-so-important inner services.
# Oftentimes it's much faster than asking and useless waiting for dumb password for required service.
# Author: me :)
#
# Zero-config, use only CLI arguments.
# Usage: CMD http://username:@example.com/ [http://:password@domain.com/ [http://domain.com/]]
# ------------------------------

# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/colors.sh"

if [[ $# -eq 0 ]]; then
    echo -e "${COLOR_RED}Invalid call syntax${COLOR_RESET}"
    echo 'Usage: CMD http://username:@example.com/ [http://:password@domain.com/ [http://domain.com/]]'

    exit 1
fi

targets=("$@")

function generate () {
    echo pass

    return 0
}

function prepare () {
    echo pass

    return 0
}

for target in "${targets[@]}"; do
    http_response_code=$(curl -L --data-urlencode user="$login" --data-urlencode password="$password" "$url" -w '%{http_code}' -o /dev/null -s)

    if [[ "$http_response_code" -eq 200 ]]; then
        echo -e "${COLOR_GREEN}Success: $target $login $password.${COLOR_RESET}"
        break 2
    fi
done
