#!/bin/bash

## dump available memory

# get current state of RAM
CURR=$(free | awk '{print $4}' | head -2 | tail -1)
# for storing previous state
PREV=0
# diff between two states
DELTA=0
# specific color for particular memory state
COLOR=''
# indicate if memory amount grows or falls
SIGN=''

while true
  do
    PREV=$CURR
    CURR=$(free | awk '{print $4}' | head -2 | tail -1)
    if [ $CURR -gt $PREV ]
    then
      SIGN='+'
      COLOR='\e[92m'
      let "DELTA = $CURR - $PREV"
    elif [ $CURR -lt $PREV ]
    then
      SIGN='-'
      COLOR='\e[91m'
      let "DELTA = $PREV - $CURR"
    else
      SIGN=' '
      COLOR='\e[39m'
      DELTA=0
    fi
    echo -e '\e[2mFREE: \e[22;1m'$CURR$COLOR $SIGN$DELTA'\e[0m'
    sleep 2
  done

exit 0
