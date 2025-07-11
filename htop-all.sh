#!/usr/bin/env bash

# This script will start or attach a new tmux session with four panes, each running htop per builder.

HOSTS=(
  "darwin-builder"
  "remote-linux-builder"
  "remote-linux-x86-builder"
  "localhost"
)

# Check if tmux is installed
if ! command -v tmux &> /dev/null
then
  echo "tmux could not be found. Please install it first."
  exit
fi

# Check if a tmux session is already running
#
if tmux list-sessions 2>/dev/null | grep -q "htop"; then
  echo "A tmux session named 'htop' is already running. Attaching to it..."
  tmux attach-session -t htop
  exit 0
fi

# Create a new tmux session
tmux new-session -d -s htop

# Split the window into 4 panes
tmux split-window -h
tmux split-window -v
tmux select-pane -t 1 # I start my panes numbers from 1, not 0
tmux split-window -v

# Send htop command to each pane
for i in "${!HOSTS[@]}"; do
  host="${HOSTS[$i]}"
  tmux select-pane -t $((i+1))
  if [[ $host == "localhost" ]]; then
    tmux send-keys "htop; exit" C-m
  else
    tmux send-keys "ssh -t $host 'htop'; exit" C-m
  fi
done

# Select the first pane
tmux select-pane -t 0
# Set the window name
tmux rename-window "htop"

# Attach to the tmux session
tmux attach-session -t htop
