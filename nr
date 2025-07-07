#!/usr/bin/env bash

usage() {
  echo "Usage: $(basename "$0") [-p] [-a] [-s <systems>] [-C] PR_NUMBER"
  echo "  -p: Post the result to GitHub"
  echo "  -a: Approve the PR"
  echo "  -s: Specify systems (default: all)"
  echo "  -C: Enable CUDA support"
}

# Array of key = value strings
extra_config=()

while getopts ":aps:C" opt; do
  case $opt in
    p)
      post_result="--post-result"
      ;;
    a)
      approve_pr="--approve-pr"
      ;;
    C)
      extra_config+=("cudaSupport = true;")
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

# join extra_config array into a single string separated by ;
extra_config_str=$(IFS=' '; echo "${extra_config[*]}")

# if extra_config_str is not empty, add it to the extra-nixpkgs-config
if [ -n "$extra_config_str" ]; then
  extra_config="--extra-nixpkgs-config={ ${extra_config_str} }"
else
  extra_config=""
fi

set -x
NP=${NP:-"nixpkgs-review"}
cmd=(
  "$NP"
  pr "$@"
  --no-shell
)
if [ -n "$extra_config" ]; then
  cmd+=("$extra_config")
fi
cmd+=(${post_result} ${approve_pr})
cmd+=(--systems="${systems}")
cmd+=(--build-args="--builders 'ssh://int-linux-builder x86_64-linux,aarch64-linux - 4 10 - - -; ssh-ng://rosetta-builder aarch64-linux,x86_64-linux - 2 10 - ; ssh://linux-builder aarch64-linux - 10 20 benchmark,big-parallel,kvm,nixos-test ; ssh://linux-x86-builder x86_64-linux - 5 20 benchmark,big-parallel,kvm,nixos-test; ssh://darwin-builder x86_64-darwin,aarch64-darwin - 3 20 big-parallel'")

"${cmd[@]}"
