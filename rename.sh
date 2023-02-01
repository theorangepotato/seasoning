#!/bin/bash

season=1
episode=1
series_name="Series Name"
for file in *; do
    name="$series_name S$(printf %02d $season)E$(printf %02d $episode)"
    echo "$file >> $name"
    mv "$file" "$name"
    episode=$((episode + 1))
done
