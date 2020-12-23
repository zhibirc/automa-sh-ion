#!/bin/bash
# ------------------------------
# Clone projects you need from GitHub.
# Author: me :)
#
# Specials:
# GITHUB_USERNAME - see https://docs.github.com/en/free-pro-team@latest/github/getting-started-with-github/github-glossary#username
# GITHUB_API_TOKEN - see:
#     https://docs.github.com/en/free-pro-team@latest/github/getting-started-with-github/github-glossary#access-token
#     https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token
# ------------------------------

if [[ -f "$HOME/.config/automa-sh-ion/.config" ]]; then
    # shellcheck disable=SC1090
    . "$HOME/.config/automa-sh-ion/.config"
else
    # shellcheck disable=SC1090
    . "$(pwd)/tools/libs/colors.sh"
    echo -e "${COLOR_YELLOW}Configuration file is absent, create it or setup environment${COLOR_RESET}"
    exit 1
fi

# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/json.sh"
# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/colors.sh"
# shellcheck disable=SC1090
. "$HOME/$CLI_TOOLS_PATH/libs/format.sh"

# for the authenticated user only
REPOS_URL="https://api.github.com/user/repos"

if hash curl; then
    # it's possible to use "type=owner" query option here
    # TODO: also it's possible an issue when someone has more than 100 owned repos, so implement handling result pages
    response=$(curl -s -u "$GITHUB_USERNAME:$GITHUB_API_TOKEN" -H "Accept: application/vnd.github.v3+json" "$REPOS_URL?visibility=all&affiliation=owner&per_page=100")
elif hash wget; then
    response=$(wget --user="$GITHUB_USERNAME" --password="$GITHUB_API_TOKEN" --header="Accept: application/vnd.github.v3+json" "$REPOS_URL?visibility=all&affiliation=owner&per_page=100")
else
    echo -e "${COLOR_RED}curl/wget are absent, install one of them and try again${COLOR_RESET}"

    exit 1
fi

repos=()
line_index=0

while read -r line; do
    (( line_index++ ))
    repos+=("$line_index")
    repos+=("$line")
    repos+=("off")
done < <( echo "$response" | json_parse '[].ssh_url' )

# check if we have "dialog" (see https://linux.die.net/man/1/dialog)
if hash dialog; then
    cmd=(dialog --separate-output --checklist "Total: $line_index \nSelect repositories to clone into $(pwd):" 22 76 16)
    choices=$("${cmd[@]}" "${repos[@]}" 2>&1 >/dev/tty)
    clear
else
    # TODO
    echo "fallback to another realization"
fi

for index in $choices; do
    repo=${repos[$index*2 + $index-2]}
    repo_name=$(basename "$repo")
    repo_name=${repo_name%.git}

    git clone "$repo"

    if cd "$repo_name"; then
        npm ci
        cd ..
    else
        echo -e "${COLOR_RED}Fail to clone $repo_name${COLOR_RESET}"
    fi

    echo -e "\n${COLOR_GREEN}$(print_utf_characters 2B1D 40)${COLOR_RESET}\n"
done

echo -e "${COLOR_GREEN}Done.${COLOR_RESET}\a"

exit 0
