#!/bin/zsh
# ------------------------------
# Boilerplate creator for React components.
#
# React components are pretty isolated and elegant, but have some boilerplate common set of instructions.
# This tool creates a relatively widely used component structure, at least trying.
# ------------------------------

unsetopt MULTIOS

readonly COMPONENTS_DIR='components'
readonly CURRENT_DIR="$(basename "$(pwd)")"
readonly COMPONENT_NAME="$1"

[[ "$CURRENT_DIR" != "$COMPONENTS_DIR" ]] && printf %s\\n "Please cd into the \"$COMPONENTS_DIR\" before running this script" && exit 1
[[ -z "$COMPONENT_NAME" ]] && printf %s\\n 'Component name to create is absent, specify it as an argument' && exit 1
[[ -d ./"$COMPONENT_NAME" ]] && printf %s\\n "Component $COMPONENT_NAME is probably exists, check name correctness" && exit 1

mkdir "$COMPONENT_NAME"
cd "$COMPONENT_NAME" || exit 1

# index.js and its content
touch index.js
printf %s\\n "export * from './$COMPONENT_NAME';" > ./index.js

# <Component>.js and its content
file_name="$COMPONENT_NAME.js"
touch "$file_name"
cat > ./"$file_name" <<EOF
import React from 'react';
import PropTypes from 'prop-types';
import clsx from 'clsx';

import styles from './$COMPONENT_NAME.module.scss'

export function $COMPONENT_NAME ( props ) {}

$COMPONENT_NAME.propTypes = {};
EOF

# associated SCSS module and its content
file_name="$COMPONENT_NAME.module.scss"
touch "$file_name"
cat > ./"$file_name" <<EOF
@import '../../styles/variables';

.body {}
EOF

exit 0
