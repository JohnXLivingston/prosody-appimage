#!/bin/bash

set -euo pipefail
set -x

rootdir="$(pwd)"
prosody_build_dir="$rootdir/build/"
prosody_destination_dir="$rootdir/dist/"

if [[ ! -d "$prosody_build_dir" ]]; then
  mkdir -p "$prosody_build_dir"
fi

cd "$prosody_build_dir"

# Prerequisite: you must have python3-venv installed on your system
if [[ ! -d "venv" ]]; then
  echo "Creating the python venv..."
  python3 -m venv venv
fi

echo "Activating the python venv..."
source venv/bin/activate

echo "Installing appimage-builder..."
pip3 install appimage-builder==1.1.0

echo "Unpatching appimage-builder for ARM..."
# see https://github.com/AppImageCrafters/appimage-builder/issues/278 for more information
sed -i -E 's/^\s*"\*\*\/ld-linux-aarch64.so\*",\s*$//' venv/lib/*/site-packages/appimagebuilder/modules/setup/apprun_2/apprun2.py

echo "Copying appimage source files..."
cp "$rootdir/src/appimage_x86_64.yml" "$prosody_build_dir/appimage_x86_64.yml"
cp "$rootdir/src/appimage_aarch64.yml" "$prosody_build_dir/appimage_aarch64.yml"
cp "$rootdir/src/launcher.lua" "$prosody_build_dir/launcher.lua"

echo "Building Prosody x86_64..."
appimage-builder --recipe "$prosody_build_dir/appimage_x86_64.yml"

echo "Cleaning build folders before building aarch64..."
rm -rf "$prosody_build_dir/AppDir"
rm -rf "$prosody_build_dir/appimage-build"

echo "Patching appimage-builder for ARM..."
# see https://github.com/AppImageCrafters/appimage-builder/issues/278 for more information
sed -i -E 's/^\s*"\*\*\/ld-linux-x86-64.so.2",\s*$/"**\/ld-linux-x86-64.so.2", "**\/ld-linux-aarch64.so*",/' venv/lib/*/site-packages/appimagebuilder/modules/setup/apprun_2/apprun2.py

echo "Building Prosody aarch64..."
appimage-builder --recipe "$prosody_build_dir/appimage_aarch64.yml"

echo "Cleaning build folders..."
rm -rf "$prosody_build_dir/AppDir"
rm -rf "$prosody_build_dir/appimage-build"

echo "Copying Prosody dist files..."
mkdir -p "$prosody_destination_dir" && mv $prosody_build_dir/prosody-x86_64.AppImage "$prosody_destination_dir/"
mkdir -p "$prosody_destination_dir" && mv $prosody_build_dir/prosody-aarch64.AppImage "$prosody_destination_dir/"

echo "Prosody AppImages OK."

exit 0
