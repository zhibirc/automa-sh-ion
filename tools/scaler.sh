#!/bin/bash -e
# ------------------------------
# Resize/scale of image/audio/video/text files.
# Author: me :)
# ------------------------------

# for debug
set -o xtrace

# load required libraries

# firstly parse given options

if [[ -z "$*" ]]; then
    echo 'No options found!'
	exit 1
fi

while getopts 'iavt' $option; do
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
