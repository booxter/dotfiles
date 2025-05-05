#!/usr/bin/env bash

if [[ $1 == "-a" ]]; then
    approve_pr="--approve-pr"
    shift
else
    approve_pr=""
fi


nixpkgs-review pr \
    --no-shell --post-result ${approve_pr} \
    --build-args="--builders 'ssh-ng://rosetta-builder aarch64-linux,x86_64-linux - 4 10 benchmark,big-parallel,kvm,nixos-test; ssh://linux-builder aarch64-linux - 10 20 big-parallel; ssh://linux-x86-builder x86_64-linux - 4 20 big-parallel; ssh://darwin-builder x86_64-darwin,aarch64-darwin - 4 1 big-parallel'" \
    --systems 'all' $@
