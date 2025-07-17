#!/usr/bin/env bash

set -euo pipefail

# This script deploys a Kind cluster with an IC HA setup.
#
mkdir -p ~/src
cd ~/src

# Clone the repository if it doesn't exist
if [ ! -d "ovn-kubernetes" ]; then
	git clone git@github.com:ovn-kubernetes/ovn-kubernetes
fi

cd ovn-kubernetes

# TODO: Remove this when the issue is fixed
find . -name '*.sh' -exec sed -i 's|^#!/bin/bash|#!/usr/bin/env bash|g' {} \;

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

export OVN_HA=false
export OVN_ENABLE_INTERCONNECT=true
export KIND_NUM_WORKER=3

./kind.sh
popd

ln -sf ~/ovn.conf ~/.kube/config
