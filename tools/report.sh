#!/bin/bash
# ------------------------------
# Report about daily activities.
# Author: me :)
# ------------------------------

TOGGL_API_TOKEN='1234'
TOGGL_API_URL='https://api.track.toggl.com/reports/api/v2/weekly'

if hash curl
    then
#        curl -v -u "$TOGGL_API_TOKEN:api_token" \
#            -H "Content-Type: application/json" \
#            -d '{"workspace_id": 1234, "project": "test", "user_agent": "api_test", "since": "2020-12-03", "until": "2020-12-04"}' \
#            -X GET "$TOGGL_API_URL"

        curl -v -u "$TOGGL_API_TOKEN:api_token" "$TOGGL_API_URL?workspace_id=1234&project=test&user_agent=api_test&since=2020-12-02&until=2020-12-04"
    elif hash wget
    then
        wget "$TOGGL_API_URL"
    else
        echo "curl/wget are absent, install one of them and try again"

        exit 1
fi

# TODO

exit 0
