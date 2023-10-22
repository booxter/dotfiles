#!/usr/bin/env bash
set -e

# TODO: introspect repo instead of listing each module here
DOT_FOLDERS="bash,git,gri,home_bin,iterm2,nvim,tmux,zsh"

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

