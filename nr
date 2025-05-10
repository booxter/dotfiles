#!/usr/bin/env bash

usage() {
    echo "Usage: $(basename "$0") [-p] [-a] [-s <systems>] [-C] PR_NUMBER"
    echo "  -p: Post the result to GitHub"
    echo "  -a: Approve the PR"
    echo "  -s: Specify systems (default: all)"
    echo "  -C: Enable CUDA support"
}

while getopts ":aps:C" opt; do
    case $opt in
        p)
            post_result="--post-result"
            ;;
        a)
            approve_pr="--approve-pr"
            ;;
        C)
            extra_config="cudaSupport = true;"
            ;;
        s)
            systems="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))


systems=${systems:-"all"}
extra_config=${extra_config:-""}


set -x
nixpkgs-review pr $@ \
    --no-shell \
    --extra-nixpkgs-config "{ ${extra_config} }" \
    ${post_result} ${approve_pr} \
    --systems="${systems}" \
    --build-args="--builders 'ssh-ng://rosetta-builder aarch64-linux,x86_64-linux - 2 10 - ; ssh://linux-builder aarch64-linux - 10 20 benchmark,big-parallel,kvm,nixos-test ; ssh://linux-x86-builder x86_64-linux - 5 20 benchmark,big-parallel,kvm,nixos-test; ssh://darwin-builder x86_64-darwin,aarch64-darwin - 3 20 big-parallel'"
