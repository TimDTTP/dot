#!/bin/sh
# ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'

# Loads defined colors
source "$HOME/.config/colors.sh"

IS_VPN=$(/usr/local/bin/piactl get connectionstate)
# IS_VPN="Disconnected"
REGION="$(/usr/local/bin/piactl get region)"
# CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
CURRENT_WIFI="$(ipconfig getsummary en0)"
# IP_ADDRESS="$(ipconfig getifaddr en0)"
IP_ADDRESS="$(echo "$CURRENT_WIFI" | grep -o "yiaddr = .*" | sed 's/^yiaddr = //')"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID : .*" | sed 's/^SSID : //' | tail -n 1)"
# CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [[ $IS_VPN != "Disconnected" && $SSID != "" ]]; then
  ICON=􁓤
  ICON_COLOR=$COLOR_FOREGROUND
elif [[ $SSID != "" ]]; then
  ICON=􀙇
  ICON_COLOR=$COLOR_FOREGROUND
else
  ICON=􀙈
  ICON_COLOR=$COLOR_FOREGROUND
fi

render_bar_item() {
  sketchybar --set $NAME \
    icon=$ICON \
    icon.color=$ICON_COLOR 
}

render_popup() {
  if [ "$IS_VPN" != "Disconnected" ]; then
    args=(
      --set wifi.ssid label="$SSID"
      --set wifi.ipaddress label="$IP_ADDRESS"
      --set wifi.region label="$REGION"
      click_script="printf $IP_ADDRESS | pbcopy;sketchybar --set wifi popup.drawing=toggle"
    )
  elif [ "$SSID" != "" ]; then
    args=(
      --set wifi.ssid label="$SSID"
      --set wifi.ipaddress label="$IP_ADDRESS"
      --set wifi.region label="Unsecured"
      click_script="printf $IP_ADDRESS | pbcopy;sketchybar --set wifi popup.drawing=toggle"
    )
  else
    args=(
      --set wifi.ssid label="Not connected"
      --set wifi.ipaddress label="No IP"
      )
  fi

  sketchybar "${args[@]}" >/dev/null
}

update() {
  render_bar_item
  render_popup
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
"routine" | "forced")
  update
  ;;
"mouse.clicked")
  popup toggle
  ;;
esac
