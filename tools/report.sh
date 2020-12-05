#!/bin/bash
# ------------------------------
# Report about daily activities.
# Author: me :)
#
# Specials:
# TOGGL_API_TOKEN - see https://github.com/toggl/toggl_api_docs#api-token
# TOGGL_WORKSPACE_ID - see https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspaces.md
# ------------------------------

TOGGL_API_URL='https://api.track.toggl.com/reports/api/v2/summary'
YESTERDAY="$(date --date='yesterday' +%F)"
TODAY="$(date +%F)"

url="$TOGGL_API_URL?workspace_id=$TOGGL_WORKSPACE_ID&since=$YESTERDAY&until=$TODAY&user_agent=api_test"

if hash curl; then
        curl -v -u "$TOGGL_API_TOKEN:api_token" "$url"
    elif hash wget; then
        wget --user="$TOGGL_API_TOKEN" --password='api_token' "$url"
    else
        echo "curl/wget are absent, install one of them and try again"

        exit 1
fi

# TODO

exit 0
