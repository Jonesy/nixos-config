#!/bin/sh
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '/Volume:/ {printf("%s", $2)}')
is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '/Volume:/ {print $3}')

volume_percentage="N/A"
if [ "$volume" != "" ]; then
  volume_percentage=$(printf "%.0f" "$(echo "$volume * 100" | bc -l 2>/dev/null)")
fi

if [ "$is_muted" = "[MUTED]" ]; then 
  icon=""
else
  icon="󰕾" 
fi

printf "^fg(04d1f9)%s^fg() %s%%\n" "$icon" "$volume_percentage"
