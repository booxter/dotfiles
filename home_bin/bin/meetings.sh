#!/bin/sh

if [ "x" = "x${DATE}" ]; then
  if [ ! $# -eq 1 ]; then
    DATE=$(date "+%Y-%m-%d")
  else
    DATE=$1
  fi
fi

meetings() {
  ~/bin/icalBuddy \
    -b "- " -nnr " " -eed -npn -nc -ps "/ --- /" \
    -iep "title,notes" -po "title,notes" \
    -df "%Y-%M-%D" \
    eventsFrom:$DATE to:$DATE \
  | grep 'meet.google.com\|kaltura.com' | grep reclaim.ai
}

name() {
  echo $1 |\
  sed "s/ ---.*$//g" |\
  sed "s/^-/$DATE/g" |\
  sed "s/[\/|]/~/g" |\
  sed "s/:/-/g"
}

url() {
  echo "$1" | grep -E -o 'https://([^ ]*?)(meet.google.com|kaltura.com)/([^ "]*)' | head -n 1
}

IFS=$'\n'
for m in $(meetings); do
  url=$(url "$m")
  if [ "x" = "x$url" ]; then
    echo $(name "$m")
  else
    IFS=$' '
    echo $(url "$m") $(name "$m")
  fi
done
