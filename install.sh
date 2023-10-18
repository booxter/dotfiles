#!/usr/bin/env bash
set -e
DOT_FOLDERS="bash,git,iterm2,nvim,tmux,zsh"

stow --verbose -t $HOME --restow $(echo $DOT_FOLDERS | sed "s/,/ /g")

if [ ! -e $HOME/.git-pw-token-config ]; then
	cp git-pw-token-config $HOME/.git-pw-token-config
	echo "Don't forget to configure git [pw] token!"
fi

# Reload shell once installed
echo "[+] Reloading shell..."
exec $SHELL -l
