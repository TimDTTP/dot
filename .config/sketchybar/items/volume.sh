#!/bin/sh

sketchybar --add item volume right \
           --set volume background.drawing=off \
                        label.drawing=off \
                        padding_left=14 \
                        script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change

