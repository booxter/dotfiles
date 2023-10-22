#!/usr/bin/env bash
set -e

# TODO: introspect repo instead of listing each module here
DOT_FOLDERS="bash,git,gri,home_bin,iterm2,nvim,tmux,zsh"

stow --verbose -t $HOME --restow $(echo $DOT_FOLDERS | sed "s/,/ /g")

if [ ! -e $HOME/.gitconfig.local ]; then
	cp gitconfig.local $HOME/.gitconfig.local
	echo "Don't forget to configure .gitconfig.local"
fi
