#!/bin/sh
wifi_network=$(nmcli connection show --active | awk 'NR==2 { print $1 }')
icon="󰖩"

if [ "$wifi_network" == "" ]; then
  icon="󱚵"
fi

printf "%s %s" "$icon" "$wifi_network"
