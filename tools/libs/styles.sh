#!/bin/bash -e
# ------------------------------
# Basic TTY colors and styles.
# ------------------------------

# mark all for export to the environment of subshells
set -o allexport

# style reset
STYLE_RESET='\033[0m'

# regular colors
BLACK='\033[0;30m'
WHITE='\033[0;37m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'

# bold style for regular colors
BOLD_BLACK='\033[1;30m'
BOLD_WHITE='\033[1;37m'
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_BLUE='\033[1;34m'
BOLD_YELLOW='\033[1;33m'
BOLD_PURPLE='\033[1;35m'
BOLD_CYAN='\033[1;36m'

# underline style for regular colors
UNDERLINE_BLACK='\033[4;30m'
UNDERLINE_WHITE='\033[4;37m'
UNDERLINE_RED='\033[4;31m'
UNDERLINE_GREEN='\033[4;32m'
UNDERLINE_BLUE='\033[4;34m'
UNDERLINE_YELLOW='\033[4;33m'
UNDERLINE_PURPLE='\033[4;35m'
UNDERLINE_CYAN='\033[4;36m'

# regular colors as background
BG_BLACK='\033[40m'
BG_WHITE='\033[47m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_BLUE='\033[44m'
BG_YELLOW='\033[43m'
BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'

# high intensity/bright colors
BRIGHT_BLACK='\033[0;90m'
BRIGHT_WHITE='\033[0;97m'
BRIGHT_RED='\033[0;91m'
BRIGHT_GREEN='\033[0;92m'
BRIGHT_BLUE='\033[0;94m'
BRIGHT_YELLOW='\033[0;93m'
BRIGHT_PURPLE='\033[0;95m'
BRIGHT_CYAN='\033[0;96m'

# bold style for high intensity/bright colors
BOLD_BRIGHT_BLACK='\033[1;90m'
BOLD_BRIGHT_WHITE='\033[1;97m'
BOLD_BRIGHT_RED='\033[1;91m'
BOLD_BRIGHT_GREEN='\033[1;92m'
BOLD_BRIGHT_BLUE='\033[1;94m'
BOLD_BRIGHT_YELLOW='\033[1;93m'
BOLD_BRIGHT_PURPLE='\033[1;95m'
BOLD_BRIGHT_CYAN='\033[1;96m'

# high intensity/bright colors as background
BG_BRIGHT_BLACK='\033[0;100m'
BG_BRIGHT_WHITE='\033[0;107m'
BG_BRIGHT_RED='\033[0;101m'
BG_BRIGHT_GREEN='\033[0;102m'
BG_BRIGHT_BLUE='\033[0;104m'
BG_BRIGHT_YELLOW='\033[0;103m'
BG_BRIGHT_PURPLE='\033[0;105m'
BG_BRIGHT_CYAN='\033[0;106m'

# disable corresponding mode
set +o allexport
