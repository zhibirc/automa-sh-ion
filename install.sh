#!/usr/bin/env bash
#
# Selective installer for presented tools.
#
########################################################################################################################

[[ ! -d "$HOME/bin/" ]] && mkdir "$HOME/bin/"
PATH=${PATH}:$HOME/bin/
export PATH

# desired mode of installed files
readonly MODE=0755


