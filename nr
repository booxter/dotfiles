#!/usr/bin/env bash

if [[ $1 == "-a" ]]; then
    approve_pr="--approve-pr"
    shift
else
    approve_pr=""
fi


nixpkgs-review pr \
    --no-shell --post-result ${approve_pr} \
    --build-args="--builders 'ssh-ng://rosetta-builder aarch64-linux,x86_64-linux - 2 10 - ; ssh://linux-builder aarch64-linux - 10 20 benchmark,big-parallel,kvm,nixos-test ; ssh://linux-x86-builder x86_64-linux - 5 20 benchmark,big-parallel,kvm,nixos-test; ssh://darwin-builder x86_64-darwin,aarch64-darwin - 3 20 big-parallel'" \
    --systems 'all' $@
