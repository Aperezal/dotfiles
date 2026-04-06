#!/bin/sh

ip_target=$(cat /home/apereza/.config/waybar/scripts/target | awk '{print $1}')
name_target=$(cat /home/apereza/.config/waybar/scripts/target | awk '{print $2}')

if [ "$ip_target" ] && [ "$name_target" ]; then
    # If both IP and Name exist
    echo "<span color='#cf9fff'>󰓾</span> <span color='#ffffff'>$ip_target - $name_target</span>"
elif [ "$(cat /home/apereza/.config/bspwm/scripts/target | wc -w)" -eq 1 ]; then
    # If only the IP exists
    echo "<span color='#cf9fff'>󰓾</span> <span color='#ffffff'>$ip_target</span>"
else
    # If the file is empty
    echo "<span color='#cf9fff'>󰓾</span> <span color='#ffffff'>No target</span>"
fi
