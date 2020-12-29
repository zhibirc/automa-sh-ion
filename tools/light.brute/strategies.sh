#!/bin/bash
# ------------------------------
# ABOUT:
# In reality, there is no silver bullet for cracking all security implementations.
# Each case may be unique and individual. So we offer only the common engine mechanism for security testing.
# Feel free to tune them for your own needs.
#
# AUTHOR:
# @zhibirc
# ------------------------------

declare MIN_LENGTH=1
declare -a PORT_LIST=(21 22 23 25 53 80 110 139 162 389 443 445 512 513 514 993 1433 1521 3306 3389 5432 5900 5901 8000 8080 6667)

function generate_random () {
    length=${1:=$MIN_LENGTH}

    tr -dc a-z0-9 < /dev/urandom | head -c "$length" | xargs
}


function scan () {
    target=$1
    ports=${2:=${PORT_LIST[@]}}

    nmap -T4 -P0 --open "$target" -p "${ports[@]}" -oX ./logs/scan.txt
}
