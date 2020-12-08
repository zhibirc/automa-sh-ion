#!/bin/bash

if [[ -f "$HOME/.config/automa-sh-ion/.config" ]]; then
    # shellcheck disable=SC1090
    . "$HOME/.config/automa-sh-ion/.config"
else
    echo -e "${COLOR_YELLOW}Configuration file is absent, create it or setup environment${COLOR_RESET}"
fi

# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/json.sh"
# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/colors.sh"

# for the authenticated user only
REPOS_URL="https://api.github.com/user/repos"

#ssh_url
if hash curl; then
    response=$(curl -s -u "$GITHUB_USERNAME:$GITHUB_API_TOKEN" "$REPOS_URL?type=owner")
elif hash wget; then
    response=$(wget --user="$GITHUB_USERNAME" --password="$GITHUB_API_TOKEN" "$REPOS_URL")
else
    echo -e "${COLOR_RED}curl/wget are absent, install one of them and try again.${COLOR_RESET}"

    exit 1
fi

data=$(echo "$response" | json_parse '[].ssh_url')

echo "$data"

echo -e "${COLOR_GREEN}All your repositories are successfully cloned.${COLOR_RESET}"

exit 0
