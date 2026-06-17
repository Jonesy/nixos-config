#!/bin/sh
wifi_network=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')
signal=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | awk -F: '$1=="yes"{print $2}')
icon="󰖩"

if [ "$wifi_network" = "" ]; then
  icon="󱚵"
fi

printf "^fg(FDF4AF)%s  ^fg()%s (%s%%)" "$icon" "$wifi_network" "$signal"
