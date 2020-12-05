#!/bin/bash

## dump available memory

while true
  do
    MEM_FREE=`cat /proc/meminfo | grep -i "^MemFree:" | awk {'print $2'}`
    MEM_CACHED=`cat /proc/meminfo | grep -i "^Cached:" | awk {'print $2'}`
    MEM_ACTIVE=`cat /proc/meminfo | grep -i "^Active:" | awk {'print $2'}`
    MEM_COMMITED=`cat /proc/meminfo | grep -i "^Committed_AS:" | awk {'print $2'}`

    let "MEM_REAL_FREE = $MEM_FREE + $MEM_CACHED"

    echo -e "\e[91m"$MEM_REAL_FREE '\e[0m( FREE: '$MEM_FREE' CACHE: '$MEM_CACHED' ACT: '$MEM_ACTIVE' COMMITED: '$MEM_COMMITED ')'

    sleep 2
  done

exit 0
