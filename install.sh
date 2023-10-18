#!/usr/bin/env bash
set -e

# TODO: introspect repo instead of listing each module here
DOT_FOLDERS="bash,git,home_bin,iterm2,nvim,tmux,zsh"

stow --verbose -t $HOME --restow $(echo $DOT_FOLDERS | sed "s/,/ /g")

if [ ! -e $HOME/.git-pw-token-config ]; then
	cp git-pw-token-config $HOME/.git-pw-token-config
	echo "Don't forget to configure git [pw] token!"
fi
