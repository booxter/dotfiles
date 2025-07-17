#!/usr/bin/env bash

set -euo pipefail

# source file from the running script dir
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$SCRIPTDIR/kind-common-vars"

# This script deploys a Kind cluster with an IC HA setup.
#
mkdir -p ~/src
cd ~/src

# Clone the repository if it doesn't exist
if [ ! -d "ovn-kubernetes" ]; then
	git clone git@github.com:ovn-kubernetes/ovn-kubernetes
fi

cd ovn-kubernetes

# Build first
pushd go-controller

make
popd

# Buld images
pushd dist/images
make fedora-image
popd

# Create the Kind cluster
pushd contrib
export KUBECONFIG=${HOME}/ovn.conf

./kind.sh
popd

ln -sf ~/ovn.conf ~/.kube/config
