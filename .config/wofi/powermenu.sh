#!/bin/bash

# entries="  \t Lock\n   \t Suspend\n   \t Log Out\n   \t Restart\n   \t Shutdown"
entries="‎ Lock ‎\n ‎ Suspend ‎\n ‎ Log Out ‎\n ‎ Restart ‎\n ‎ Power Off ‎"

# selected=$(echo -e $entries|wofi --width 10% --lines 6 --dmenu -Dhide_search=true --hide-scroll -Dcontent_halign=center -s ~/.config/wofi/powerstyle.css --cache-file /dev/null | awk '{print tolower($2)}')
selected=$(echo -e $entries|wofi --width 10% --lines 7 --dmenu -Dhide_search=true --hide-scroll -s ~/.config/wofi/powerstyle.css --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  lock) exec sh -c '(sleep 0.5s; swaylock --grace 0)' & disown ;;
  suspend) exec systemctl suspend;;
  logout) exec hyprctl dispatch exit NOW;;
  reboot) exec systemctl reboot;;
  shutdown) exec systemctl poweroff -i;;
esac
