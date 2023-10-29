#!/bin/bash
# Find a filename to use as a temp file
#
# Stolen from https://blog.landofcrispy.com/index.php/2021/01/06/clipboard-integration-between-tmux-nvim-zsh-x11-across-ssh-sessions/

if [ x"$1" = x"-o" ]; then
  tmux show-buffer
else
  TEMPFILE="`tempfile 2>/dev/null`"
  if [ $? -ne 0 ]; then
    TEMPFILE="/tmp/_clip_temp_yssh$USER"
  fi

  # Save stdin to file
  cat > "$TEMPFILE"

  # Load tmux buffer
  tmux load-buffer -w "$TEMPFILE"

  # Remove file
  rm -f "$TEMPFILE"
fi
