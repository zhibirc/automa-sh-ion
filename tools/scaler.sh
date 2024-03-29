#!/usr/bin/env bash
#
# Resize/scale of image/audio/video/text files. Use FFmpeg and ImageMagick tools suite.
# Written by Yaroslav Surilov aka zhibirc <zhibirc.echo@gmail.com> on 2021-03
########################################################################################################################

# for debug
#set -o xtrace -o nounset -o pipefail

readonly BASE_DIR="$(dirname "$0")"
readonly VERSION='1.0.0'

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
    echo -e "${RED}${1:-Scaler, the general information}${STYLE_RESET}\n"

    cat <<EOF
Available options:

-h, --help
Print this Help and exit.

-V, --version
Print software version and exit.

-d, --debug
Use debugging mode with a lot of execution details. Can be combined with other modes.

-i, --images
Use images scaling or "images" mode.

-a, --audio
Use "audio" mode for reducing bitrate or track duration.

-v, --video
Use "video" mode for scaling videos.

-s, --source
Source path for input files, required.

-o, --output
Destination path for output files, use directory of origin files by default.

-r, --resolution
Shorthand for convenience: SD (640x480), HD (1280x720), FullHD (1920x1080), UHD or 4K (3840x2160). Case insensitive.

EOF
}

if [[ -z "$*" ]]; then
    help 'Too few arguments\n' && exit 1
fi

declare -a POSITIONAL=()

while [[ "$#" -gt 0 ]]; do
    key="$1"

    case "$key" in
        -h|--help)    help && exit 0;;
        -V|--version) echo -e "${GREEN}$VERSION${STYLE_RESET}" && exit 0;;
        v) echo 'video';;
        t) echo 'text';;
        *) echo "invalid option: $key";;
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
