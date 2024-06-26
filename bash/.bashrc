# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f $HOME/.bashrc.local ]; then
  . $HOME/.bashrc.local
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/go/bin:$HOME/Library/Python/3.11/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

unset rc

function _update_ps1() {
    PS1="$(powerline-go -cwd-max-depth 3 -hostname-only-if-ssh -max-width 40 -error $? -jobs $(jobs -p | wc -l))"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

if [ "$TERM" != "linux" ] && type powerline-go 1> /dev/null; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# run tmux in an interactive ssh session
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  export DISPLAY=fake # make pass assume it can use xclip
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}
#. $HOME/.bash_prompt
