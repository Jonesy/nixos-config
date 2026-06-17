#!/usr/sh
max_brightness="$(brightnessctl max)"
brightness="$(brightnessctl get)"
brightness_percentage=$(printf "%.0f" "$(echo "$brightness / $max_brightness * 100" | bc -l 2>/dev/null )")

if [ "$brightness_percentage" -lt 15 ]; then icon="󰃝"
elif [ "$brightness_percentage" -lt 45 ]; then icon="󰃞"
elif [ "$brightness_percentage" -lt 65 ]; then icon="󰃟"
else icon="󰃠"
fi

printf "%s %s%%" "$icon" "$brightness_percentage"
