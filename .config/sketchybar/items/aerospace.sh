#!/bin/sh

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
               --subscribe space.$sid aerospace_workspace_change \
               --set space.$sid \
                     background.color=$COLOR_FOREGROUND \
                     background.corner_radius=6 \
                     background.height=28 \
                     background.padding_right=0 \
                     background.drawing=off \
                     icon="$sid" \
                     icon.color=$COLOR_FOREGROUND \
                     icon.font.family="SF Mono" \
                     icon.font.style="Bold" \
                     icon.padding_left=5 \
                     icon.padding_right=5 \
                     click_script="aerospace workspace $sid" \
                     script="$PLUGIN_DIR/aerospace.sh $sid"
done

sketchybar --set space.1 background.padding_left=15
sketchybar --set space.9 background.padding_right=15


