#!/bin/sh

sketchybar --add item chevron left \
           --set chevron icon=􀯻 icon.padding_right=2 label.drawing=off \
           --add item front_app left \
           --set front_app icon.drawing=off \
                           script="$PLUGIN_DIR/front_app.sh" \
                           padding_right=14 \
           --subscribe front_app front_app_switched
