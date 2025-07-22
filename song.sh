#!/usr/bin/env bash

response=$(spotify_player get key playback)

artist_names=$(echo "$response" | jq -r '.item.artists[].name' | paste -sd ", ")
track_name=$(echo "$response" | jq -r '.item.name')

echo "$artist_names - $track_name"
