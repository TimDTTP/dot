#!/bin/sh

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

apple_logo=(
  icon="􀣺"
  icon.font="SF Pro:Bold:16.0"
  icon.color=$COLOR_FOREGROUND
  icon.width=16
  icon.padding_left=0
  icon.padding_right=0
  background.drawing=off
  label.drawing=off
  padding_left=14
  padding_right=14
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
  popup.background.color=$COLOR_BACKGROUND
  popup.background.corner_radius=3
  popup.background.border_width=1
  popup.background.border_color=$COLOR_FOREGROUND
)

apple_prefs=(
  icon="􀍟"
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

apple_activity=(
  icon="􀊫"
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
  icon="􀎡"
  label="Lock Screen" click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${apple_prefs[@]}"       \
                                                       \
           --add item apple.activity popup.apple.logo  \
           --set apple.activity "${apple_activity[@]}" \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${apple_lock[@]}"
