#!/bin/bash

. colors.sh

sleep 1
ping -c 1 google.com >/dev/null 2>&1
exit_code="$?"

if [ $exit_code == "0" ]; then
    echo -e "${COLOR_GREEN}[✔]::[Internet Connection]: CONNECTED${COLOR_RESET}"
else
    if [ $exit_code == "1" ]; then
        echo -e "${COLOR_YELLOW}[✔]::[Internet Connection]: LOCAL ONLY${COLOR_RESET}"
    elif [ $exit_code == "2" ]; then
        echo -e "${COLOR_RED}[✔]::[Internet Connection]: OFFLINE${COLOR_RESET}"
    fi

    if ping -c 1 8.8.4.4 >/dev/null 2>&1; then
        echo -e "${COLOR_RED}[X] Not able to resolve hostnames over terminal using ping${COLOR_RESET}"
    fi
fi
