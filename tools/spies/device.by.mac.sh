#!/usr/bin/env bash
# ------------------------------
# Scan target environment and find a network device by given MAC address.
########################################################################################################################

# for debug
set -o xtrace

if [[ -z "$*" ]]; then
    exit 1
fi

declare -a results

test () {
    ping -c 1 "$1" &> /dev/null
    echo "$?"
}

for mac in "$@"; do
    # use MAC address as an argument to find corresponding IP
    ip neighbor | grep "$mac" | cut -d" " -f1

    results=$(sudo arp-scan --localnet --quiet --ignoredups | grep "$mac" | awk '{print $1}')
done

echo "$results"

exit $?


