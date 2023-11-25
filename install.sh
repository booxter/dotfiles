#!/usr/bin/env bash
set -e

# TODO: introspect repo instead of listing each module here
DOT_FOLDERS="bash,git,gri,home_bin,iterm2,mutt,nvim,readline,tmux,urlview,zsh"

# TODO: reconsider a better approach to clean up system default files?
rm -f $HOME/.bashrc $HOME/.bash_profile

stow --verbose -t $HOME --restow $(echo $DOT_FOLDERS | sed "s/,/ /g")

if [ ! -e $HOME/.gitconfig.local ]; then
	cp gitconfig.local $HOME/.gitconfig.local
  chmod go-rwx $HOME/.gitconfig.local
	echo "Don't forget to configure .gitconfig.local"
fi

if [ ! -e $HOME/.netrc ]; then
	cp netrc.local $HOME/.netrc
  chmod go-rwx $HOME/.netrc
	echo "Don't forget to configure .netrc"
fi

GERTTY_CONFIG=$HOME/.config/gertty/gertty.yaml
if [ ! -e $GERTTY_CONFIG ]; then
	mkdir -p $(dirname $GERTTY_CONFIG)
	cp gertty.yaml $GERTTY_CONFIG
	chmod go-rwx $GERTTY_CONFIG
	echo "Don't forget to configure $GERTTY_CONFIG"
fi

HUBTTY_CONFIG=$HOME/.config/hubtty/hubtty.yaml
if [ ! -e $HUBTTY_CONFIG ]; then
	mkdir -p $(dirname $HUBTTY_CONFIG)
	cp hubtty.yaml $HUBTTY_CONFIG
	chmod go-rwx $HUBTTY_CONFIG
	echo "Don't forget to configure $HUBTTY_CONFIG"
fi

# install tpm
if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
