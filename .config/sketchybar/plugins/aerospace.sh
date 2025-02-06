#!/bin/sh

source "$HOME/.config/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on \
                           icon.font.size=15 \
                           icon.color=$COLOR_BACKGROUND
else
    sketchybar --set $NAME background.drawing=off \
                           icon.font.size=15 \
                           icon.color=$COLOR_FOREGROUND
fi

