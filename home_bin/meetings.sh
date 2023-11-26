#!/bin/sh

if [ ! $# -eq 1 ]; then
  DATE=$(date "+%Y-%m-%d")
else
	DATE=$1
fi

icalBuddy \
	-b "- " -nnr " " -eed -npn -nc -ps "/ --- /" \
	-iep "title,notes" -po "title,notes" \
	-df "%Y-%M-%D" \
	eventsFrom:$DATE to:$DATE |\
\
  grep meet.google.com | grep reclaim.ai |\
	sed "s/ ---.*$//g" |\
  sed "s/^-/$DATE/g"

