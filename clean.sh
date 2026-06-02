#!/usr/bin/env bash

set -euo pipefail
set -x

rootdir="$(pwd)"
prosody_build_dir="$rootdir/build/"
prosody_destination_dir="$rootdir/dist/"

echo "Removing build and destination folders..."
if [[ -d "$prosody_build_dir" ]]; then
  rm -r "$prosody_build_dir"
fi
if [[ -d "$prosody_destination_dir" ]]; then
  rm -r "$prosody_destination_dir"
fi

echo "Build environment cleaned up."

exit 0
