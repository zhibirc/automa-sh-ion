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

declare -r VERSION='v0.0.1'
declare DEBUG=false

declare -a packages_to_install
declare wordlist_path


help () {
    command_name=$(basename "$0")

    cat <<EOF
Usage examples:
$command_name http://example.com/
$command_name %username%:@http://example.com/
$command_name :%password%@http://example.com/

-h, --help
Print this Help and exit.
-V, --version
Print software version and exit.
-d, --debug
Enable debugging mode with a lot of execution details.

EOF
}


debug () {
    if [[ $DEBUG = true ]]; then
        echo ""
        declare -p "$1"
        echo ""
    fi
}


if [[ $# -eq 0 ]]; then
    echo -e "${COLOR_RED}Invalid call syntax!${COLOR_RESET}\n\a"
    help

    exit 1
fi


case $1 in
    -h|--help)
        help

        exit 0
        ;;
    -V|--version)
        echo "$VERSION"

        exit 0
        ;;
    -d|--debug)
        DEBUG=true
        set -e -v -x
        ;;
esac

clear

for dependency in nmap hydra; do
    if ! command -v "$dependency" >/dev/null 2>&1; then
        read -r -p "$(echo -e "${COLOR_YELLOW}Could not find \"$dependency\", install it? [Y/n]${COLOR_RESET}")" decision

        if [[ -z "$decision" || "$decision" == 'Y' ]]; then
            packages_to_install+=("$dependency")
        else
            echo -e "${COLOR_RED}Without \"$dependency\" some functionality will be unavailable${COLOR_RESET}"
        fi
    fi
done

if [[ "${#packages_to_install[@]}" -gt 0 ]]; then
    sudo apt-get update
    sudo apt install -y "${packages_to_install[@]}"
fi

PS3='What do you want to do? '

options=(
    'Authorize based on HTTP response code'
    'Authorize based on cookies/session'
    'Authorize based on raw generated tokens'
    'Scan for open/unsecure ports and services'
    'Quit'
)

select option in "${options[@]}"; do
    case $option in
        'Authorize based on HTTP response code')
            read -r -p 'Use default wordlist (hit ENTER) or specify path to your own: ' wordlist_path
            if [[ -z "$wordlist_path" ]]; then
                wordlist_path='rockyou.txt'
                echo -e "${COLOR_GREEN}Downloading $wordlist_path from the Web...${COLOR_RESET}"
                curl -L -s "https://github.com/brannondorsey/naive-hashcat/releases/download/data/$wordlist_path" -o $wordlist_path
                echo -e "Lines: $(wc -l $wordlist_path | awk '{print $1}')"
            fi
            break
            ;;
        'Authorize based on cookies/session')
            echo 'Cookie based'
            break
            ;;
        'Authorize based on raw generated tokens')
            read -r -p 'Select a characters amount of generated string: ' random_length
            generate_random "$random_length"
            break
            ;;
        'Scan for open/unsecure ports and services')
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
