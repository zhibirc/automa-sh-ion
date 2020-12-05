#!/usr/bin/env bash

# use MAC address as an argument to find corresponding IP
ip neighbor | grep "$@" | cut -d" " -f1