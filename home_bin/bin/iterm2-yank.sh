#!/bin/bash

if [ x"$1" = x"-o" ]; then
  echo ""
else
  echo -n -e "\033]1337;CopyToClipboard=;\a"
  echo -n "$(</dev/stdin)"
  echo -n -e "\033]1337;EndCopy\a"
fi
