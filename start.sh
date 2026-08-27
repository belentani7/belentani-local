#!/usr/bin/env sh
set -eu
node "$(dirname "$0")/bin/belentani.mjs" doctor --workspace "${1:-$(pwd)}"
