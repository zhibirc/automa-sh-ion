#!/bin/bash -x
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

VERSION='0.0.1'
HELP='Usage: CMD http://username:@example.com/ [http://:password@domain.com/ [http://domain.com/]]'

if [[ $# -eq 0 ]]; then
    echo -e "${COLOR_RED}Invalid call syntax${COLOR_RESET}"
    echo "$HELP"

    exit 1
fi

declare -r targets=("$@")
declare -a targets_map

# prepare targets
# note that there are no strict checks here
for target in "${targets[@]}"; do
    # if we have some credentials
    if [[ "$target" == *"@"* ]]; then
        url=
        #targets_map["$target"]=
    fi
done


function generate () {
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
