#!/bin/sh

sketchybar --add item battery right \
           --set battery background.drawing=off \
                         padding_right=14 \
                         update_freq=120 \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change

