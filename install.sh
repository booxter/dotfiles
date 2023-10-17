#!/usr/bin/env bash
set -e
DOT_FOLDERS="bash,git,nvim,tmux,zsh"

stow --verbose -t $HOME --restow $(echo $DOT_FOLDERS | sed "s/,/ /g")

# Reload shell once installed
echo "[+] Reloading shell..."
exec $SHELL -l
