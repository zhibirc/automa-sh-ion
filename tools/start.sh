#!/bin/bash
# ------------------------------
# Run daily working environment.
# Author: me :)
# ------------------------------

# terminal
gnome-terminal --full-screen

# browsers
nohup firefox &
nohup chromium &

# IDE
nohup pstorm &

exit 0
