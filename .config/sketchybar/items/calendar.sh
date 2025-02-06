#!/bin/sh

sketchybar --add item calendar right \
           --set calendar icon.drawing=off \
                          background.drawing=off \
                          padding_left=14 \
                          padding_right=14 \
                          label.padding_left=0 \
                          label.padding_right=0 \
                          update_freq=30 \
                          script="$PLUGIN_DIR/calendar.sh" \
                          padding_right=14
