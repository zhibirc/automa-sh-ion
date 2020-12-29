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

declare -i MIN_RANDOM_LENGTH=1
declare -a PORT_SCAN_LIST=(21 22 23 25 53 80 110 139 162 389 443 445 512 513 514 993 1433 1521 3306 3389 5432 5900 5901 8000 8080 6667)
#declare -i PORT_SCAN_THREADS=4


function generate_random () {
    length=${1:=$MIN_RANDOM_LENGTH}

    tr -dc a-z0-9 < /dev/urandom | head -c "$length" | xargs
}


function scan () {
    target=$1
    #threads=${2:=$PORT_SCAN_THREADS}

    nmap -T4 -A -v -Pn --open "$target" -p "${PORT_SCAN_LIST[@]}" -oN ./logs/scan.txt
}
