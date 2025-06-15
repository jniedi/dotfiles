#!/usr/bin/env zsh



# Checks the battery percentage and sends a notification
# if it is below 50% (normal)
# if it is below 15% (critical)


percentage=$(acpi -b | grep -oe "[0-9]*%" | grep -oe "[0-9]*")


if [[ $percentage -lt 30 ]]; then 
    notify-send --urgency normal "Battery ($percentage%) below 50%"
elif [[ $percentage -lt 15 ]]; then 
    notify-send --urgency critical "Battery $percentage%"
fi
