#!/usr/bin/env bash

# Echo a given unicode character N times.
# Usage: print_utf_characters [unicode number] [N times]
function print_utf_characters() {
    utf_character=$1
    n_times=$2
    line_template=$(printf "\u$utf_character%.0s" $(seq 1 "$n_times"); echo)

    echo "$line_template"
}
