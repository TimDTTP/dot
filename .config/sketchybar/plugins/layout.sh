#!/bin/sh

# this is jank and ugly, I know
LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev)"

# specify short layouts individually.
case "$LAYOUT" in
    "Dvorak") SHORT_LAYOUT="DV";;
    "\"U.S.\"") SHORT_LAYOUT="US";;
    "Graphite") SHORT_LAYOUT="GP";;
    *) SHORT_LAYOUT="􀇿";;
esac

sketchybar --set keyboard label="$SHORT_LAYOUT"
