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

MIN_LENGTH=1

function generate_random () {
    length=${1:=$MIN_LENGTH}

    tr -dc a-z0-9 < /dev/urandom | head -c "$length" | xargs
}
