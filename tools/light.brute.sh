#!/bin/bash
# ------------------------------
# Lightweight brute-force for access to not-so-important inner services.
# Oftentimes it's much faster than asking and useless waiting for dumb password for required service.
# Author: me :)
#
# Zero-config, use only CLI arguments.
# Usage: CMD username:@http://example.com/ [:password@https://domain.com/ [www.domain.com/path]]
# ------------------------------

if [[ -f "$HOME/.config/automa-sh-ion/.config" ]]; then
    # shellcheck disable=SC1090
    . "$HOME/.config/automa-sh-ion/.config"
else
    HOME=$(pwd)
    CLI_TOOLS_PATH='tools'
fi

# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/colors.sh"

VERSION='0.0.1'
HELP='Usage: CMD username:@http://example.com/ [:password@https://domain.com/ [www.domain.com/path]]'

if [[ $# -eq 0 ]]; then
    echo -e "${COLOR_RED}Invalid call syntax${COLOR_RESET}"
    echo "$HELP"

    exit 1
fi

declare -r targets=("$@")
declare -A targets_map

# prepare targets
# note that there are no strict checks here
for target in "${targets[@]}"; do
    # if we have some credentials
    if [[ "$target" == *"@"* ]]; then
        credentials=$(echo "$target" | cut -d @ -f 1)
        url=$(echo "$target" | cut -d @ -f 2)
        targets_map["$url"]="$credentials"
    else
        targets_map["$target"]=''
    fi
done

function generate () {
    echo pass

    return 0
}

for target in "${!targets_map[@]}"; do
    url=$target
    credentials=${targets_map[$target]}

    echo "$url"
    echo "$credentials"

#    http_response_code=$(curl -L --data-urlencode user="$login" --data-urlencode password="$password" "$url" -w '%{http_code}' -o /dev/null -s)
#
#    if [[ "$http_response_code" -eq 200 ]]; then
#        echo -e "${COLOR_GREEN}Success: $target $login $password.${COLOR_RESET}"
#        break 2
#    fi
done
