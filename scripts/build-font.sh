#!/usr/bin/env bash

set -ue

mkdir -p build
fontmake -u masters/pauley2-regular.ufo -o otf --output-path build/${FONT_NAME}-${GIT_HASH}.otf