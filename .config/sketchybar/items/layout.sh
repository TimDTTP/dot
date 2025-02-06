#!/bin/sh

keyboard=(
    icon="􀇳"
    label.font="SF Pro:Semibold:12.0"
    label.padding_right=10
    script="$PLUGIN_DIR/layout.sh"
)

sketchybar --add item keyboard right        \
           --set keyboard "${keyboard[@]}"  \
           --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
           --subscribe keyboard keyboard_change
