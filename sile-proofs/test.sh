#!/bin/bash

GIT_HASH=$(git log --pretty=format:'%h' -n 1)
docker run --env "PROOF_VERSION=$GIT_HASH" --rm --volume "$HOME/Design/Typefaces/2020-07-10-pauley3/Typeface/build:/fonts" --volume "$(pwd):/data" --user "$(id -u):$(id -g)" siletypesetter/sile:master control-chars.sil && open control-chars.pdf