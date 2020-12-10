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
    # it's possible to use "type=owner" query option here
    # TODO: also it's possible an issue when someone has more than 100 owned repos, so implement handling result pages
    response=$(curl -s -u "$GITHUB_USERNAME:$GITHUB_API_TOKEN" -H "Accept: application/vnd.github.v3+json" "$REPOS_URL?visibility=all&affiliation=owner&per_page=100")
elif hash wget; then
    response=$(wget --user="$GITHUB_USERNAME" --password="$GITHUB_API_TOKEN" --header="Accept: application/vnd.github.v3+json" "$REPOS_URL?visibility=all&affiliation=owner&per_page=100")
else
    echo -e "${COLOR_RED}curl/wget are absent, install one of them and try again.${COLOR_RESET}"

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

#printf '%s\n' "${repos[@]}"

# check if we have "dialog" (see https://linux.die.net/man/1/dialog)
if hash dialog; then
    cmd=(dialog --separate-output --checklist "Total: $line_index \nSelect repositories to clone into $(pwd):" 22 76 16)
    choices=$("${cmd[@]}" "${repos[@]}" 2>&1 >/dev/tty)
else
    echo "fallback to another realization"
fi

#echo -e "$choices\n\n"
#printf '%s\n' "${repos[@]}"

for index in $choices; do
    repo=${repos[$index*2 + $index-2]}
    repo_name=$(basename "$repo")
    repo_name=${repo_name%.git}

    #echo "$repo ::: $repo_name"

    git clone "$repo"
    cd "$repo" && npm ci
    cd ..
done

echo -e "${COLOR_GREEN}All your repositories are successfully cloned.${COLOR_RESET}"

exit 0
