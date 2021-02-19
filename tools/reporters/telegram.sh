#!/bin/bash -e
# ------------------------------
# Send Telegram report with given chat ID and message.
# Author: me :)
# ------------------------------

# for debug
set -o xtrace

declare telegram_bot_path="$1"
declare chat_id="$2"
declare telegram_bot_token="$3"
declare message="$4"

if [[ -n "$telegram_bot_path" && -n "$chat_id" && -n "$telegram_bot_token" && -n "$message" ]]; then
    # see https://github.com/fabianonline/telegram.sh for details about tool used below
    echo -e "$message" | "$telegram_bot_path" -t "$telegram_bot_token" -c "$chat_id" -M -
    exit $?
fi

exit 1
