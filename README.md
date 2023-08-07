# prosody-appimage

Appimage for the Prosody XMPP server.

## Introduction

This package provides an [AppImage](https://appimage.org/) for the [Prosody](https://prosody.im/) XMPP server,
so that the server can be run anywhere.

The AppImage is built using [appimage-builder](https://appimage-builder.readthedocs.io), and based on
[Debian packages](https://www.debian.org) to properly handle dependencies.

This repository provides appimages for following CPU architectures:

* x86_64
* ARM64

If you need another architecture, feel free to ask for by creating an issue.

This project was created for the [Peertube livechat plugin](https://livingston.frama.io/peertube-plugin-livechat),
a chatting plugin for [Peertube](https://joinpeertube.org/).

## Usage

Prosody comes with the `prosodyctl` command line tool, that allows to control Prosody.

To avoid building two appimages (one for the server, one for prosodyctl), the generated AppImage contains a wrapper:
when calling the binary, the first argument has to be `prosody` or `prododyctl`, depending on which you want to run.
Other parameters will be passed unchanged to `prosody` or `prosodyctl`.

Some examples:

```bash
# launch the server, using defaults Prosody configuration files that is included in the AppImage:
prosody-x86_64.AppImage prosody
# use prosodyctl to start the server, using a custom configuration file:
prosody-x86_64.AppImage prosodyctl start --config use_this_file.cfg.lua
```

## Build

Pre-requisite to build this repo:

* You must use a Debian-like system. Or at least have `apt` and `dpkg` available on your system (you can manually install them).
* `build-essential`
* `python3-venv`
* `squashfs-tools`

Note: These dependencies were tested on a Debian Bullseye. If there is some dependencies issues on your UNIX/Linux system, please open an issue.

To build the AppImage, just run the `build.sh` script.

Note: appimage-builder 1.1.0 has a bug for ARM64 builds. This bug was patched, but the patch was not released. So, for now,
the build script makes a hot-patch.
See [aarch64 builds made from debian repository are not working](https://github.com/AppImageCrafters/appimage-builder/issues/278) for more information.
