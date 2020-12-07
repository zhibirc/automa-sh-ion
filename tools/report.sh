#!/bin/bash
# ------------------------------
# Report about daily activities.
# Author: me :)
#
# Specials:
# TOGGL_API_TOKEN - see https://github.com/toggl/toggl_api_docs#api-token
# TOGGL_WORKSPACE_ID - see https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspaces.md
# TG_%abbreviated description%_BOT_TOKEN - Telegram Bot token (see https://core.telegram.org/bots#creating-a-new-bot)
# TG_%abbreviated description from above%_CHAT_ID - Telegram Group/Chat ID
# ------------------------------

. ./libs/json.sh

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_RESET='\033[0m'

TOGGL_API_URL='https://api.track.toggl.com/reports/api/v2/summary'
YESTERDAY="$(date --date='yesterday' +%F)"
TODAY="$(date +%F)"

url="$TOGGL_API_URL?workspace_id=$TOGGL_WORKSPACE_ID&since=$YESTERDAY&until=$TODAY&user_agent=api_test"

if hash curl; then
        response=$(curl -s -u "$TOGGL_API_TOKEN:api_token" "$url")
        data=$(echo "$response" | json_parse 'data[].items[].title.time_entry')
    elif hash wget; then
        response=$(wget --user="$TOGGL_API_TOKEN" --password='api_token' "$url")
        data=$(echo "$response" | json_parse 'data[].items[].title.time_entry')
    else
        echo -e "${COLOR_RED}curl/wget are absent, install one of them and try again.${COLOR_RESET}"

        exit 1
fi

# fixme: debug only
#echo "$data"

# specify your own message header text
report_message="#yaroslav #stats\n\n$data"

# see https://github.com/fabianonline/telegram.sh for details about tool used below
echo -e "$report_message" | ../telegram.sh/telegram -t $TG_YSIR_BOT_TOKEN -c -452318342 -

echo -e "${COLOR_GREEN}Report successfully created and send.${COLOR_RESET}"
exit 0
