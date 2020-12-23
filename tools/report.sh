#!/bin/bash
# ------------------------------
# Report about daily activities.
# Author: me :)
#
# Specials:
# TOGGL_API_TOKEN - see https://github.com/toggl/toggl_api_docs#api-token
# TOGGL_WORKSPACE_ID - see https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspaces.md
# TG_%abbreviated description%_BOT_TOKEN - Telegram Bot TOKEN (see https://core.telegram.org/bots#creating-a-new-bot)
# To obtain the Group ID for below constant just use "curl "https://api.telegram.org/bot<bot_token>/getUpdates" after adding to chat and analyze the output.
# TG_%abbreviated description from above%_CHAT_ID - Telegram Group/Chat ID
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

TOGGL_API_URL='https://api.track.toggl.com/reports/api/v2/summary'
YESTERDAY="$(date --date='yesterday' +%F)"
TODAY="$(date +%F)"

url="$TOGGL_API_URL?workspace_id=$TOGGL_WORKSPACE_ID&since=$YESTERDAY&until=$TODAY&user_agent=api_test"

if hash curl; then
    response=$(curl -s -u "$TOGGL_API_TOKEN:api_token" "$url")
elif hash wget; then
    response=$(wget --user="$TOGGL_API_TOKEN" --password='api_token' "$url")
else
    echo -e "${COLOR_RED}curl/wget are absent, install one of them and try again.${COLOR_RESET}"

    exit 1
fi

data=$(echo "$response" | json_parse 'data[].items[].title.time_entry')
data=$(echo "$data" | sed "s~[[:digit:]]\{5\}~[&]($TASK_TRACKER_URL&)~g")
time=$(echo "$response" | json_parse 'total_grand')
time=$(awk "BEGIN {printf \"%.2f\n\", $time/1000/60/60}")

# specify your own message header text
report_message="#yaroslav #stats\n\n$data\n\nTime (hours): $time"

# see https://github.com/fabianonline/telegram.sh for details about tool used below
echo -e "$report_message" | "$HOME/$CLI_TOOLS_PATH/../telegram.sh/telegram" -t "$TG_YSIR_BOT_TOKEN" -c "$TG_YSIR_CHAT_ID" -M -

echo -e "${COLOR_GREEN}Report successfully created and send.${COLOR_RESET}"

exit 0
