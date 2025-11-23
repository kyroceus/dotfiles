#!/bin/bash

notification_threshold=40
suspend_threshold=35
hibernate_threshold=30

battery_info=$(acpi -b)
battery_level=$(echo "$battery_info" | grep -P -o '[0-9]+(?=%)')
is_discharging=$(echo "$battery_info" | grep -i "discharging")


if [[ -n "$is_discharging" ]]; then
	# if [[ "$battery_level" -le "$hibernate_threshold" ]]; then
	# 	systemctl hibernate
	# elif [[ "$battery_level" -le "$suspend_threshold" ]]; then
	# 	systemctl suspend
	if [[ "$battery_level" -le "$notification_threshold" ]]; then
		notify-send -u critical "Low Battery" "Battery is at ${battery_level}%. Plug in your charger!"
		paplay /usr/share/sounds/custom/error.mp3
	fi
elif [[ "$battery_level" -eq 100 ]]; then
		notify-send -u normal -i battery-full "Battery full" "Battery is at ${battery_level}%. Please unplug the charger!"
		paplay /usr/share/sounds/freedesktop/stereo/complete.oga
fi

