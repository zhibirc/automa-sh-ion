#!/bin/bash -e
# ------------------------------
# Resize/scale of image/audio/video/text files.
# Written by Yaroslav Surilov aka zhibirc <zhibirc.echo@gmail.com> on 2021-03
# ------------------------------

# for debug
set -o xtrace -o nounset -o pipefail

readonly BASE_DIR="$(dirname "$0")"

if [[ -f "$BASE_DIR/libs/styles.sh" ]]; then
    # shellcheck disable=SC1090
    . "$BASE_DIR/libs/styles.sh"
elif [[ -d tools && -d tools/libs ]]; then
    cd tools || { echo >&2 "Tools directory exists but I can't cd there."; exit 1; }

    . "./libs/styles.sh"
else
    echo 'Please cd into the tools before running this script.'; exit 1;
fi


help () {
    echo -e "${RED}$0${STYLE_RESET}"

    cat <<EOF
Usage examples:

-h, --help
Print this Help and exit.
-v, --version
Print software version and exit.
-d, --debug
Enable debugging mode with a lot of execution details.

EOF
}

if [[ -z "$*" ]]; then
    help 'Too few arguments\n' && exit 1
fi

while getopts 'hiavt' $option; do
    case "$option" in
        i) echo 'images';;
        a) echo 'audio';;
        v) echo 'video';;
        t) echo 'text';;
        *) echo "invalid option: $option";;
    esac
done

#FOLDER
#WIDTH
#HEIGHT

#resize png or jpg to either height or width, keeps proportions using imagemagick
#find ${FOLDER} -iname '*.jpg' -o -iname '*.png' -exec convert \{} -verbose -resize $WIDTHx$HEIGHT\> \{} \;

#resize png to either height or width, keeps proportions using imagemagick
#find ${FOLDER} -iname '*.png' -exec convert \{} -verbose -resize $WIDTHx$HEIGHT\> \{} \;

#resize jpg only to either height or width, keeps proportions using imagemagick
#find ${FOLDER} -iname '*.jpg' -exec convert \{} -verbose -resize $WIDTHx$HEIGHT\> \{} \;

# alternative
#mogrify -path ${FOLDER} -resize ${WIDTH}x${HEIGHT}% *.png -verbose

echo -e "${COLOR_GREEN}Done.${COLOR_RESET}\a"

exit 0
