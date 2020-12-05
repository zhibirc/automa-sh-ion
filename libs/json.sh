#!/bin/bash
# ------------------------------
# Report about daily activities.
# Author: me :)
# ------------------------------

json_parse () {
    field="$1"

    # jq - Command-line JSON processor
    if hash jq; then
        return "$(jq -r ".$field")"
    elif hash python3; then
        return "$(python3 -c "import json; print(json.load($data)[$field])")"
    else
        echo 'There are no instruments to parse JSON format, install Python or jq, please'

        return 1
    fi
}
