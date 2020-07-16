#!/usr/bin/env bash

set -ue

version=${FONT_VERSION:-$SEMAPHORE_GIT_SHA}

mkdir -p build
fontmake -u $UFO_PATH -o otf --output-path ${OUTPUT_PATH}/${FONT_NAME_STYLE}-${version}.otf