#!/usr/bin/env bash

set -euo pipefail
set -x

rootdir="$(pwd)"

/usr/bin/env bash clean.sh
/usr/bin/env bash build.sh

exit 0
