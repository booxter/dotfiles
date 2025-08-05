#!/usr/bin/env bash

set -euo pipefail

# source file from the running script dir
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$SCRIPTDIR/kind-common-vars"

cd ~/src/ovn-kubernetes
make -C test control-plane WHAT="$*"
