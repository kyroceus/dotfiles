#!/bin/bash

# 1. Notify and Scan
notify-send "  Scanning Wi-Fi Networks..."
nmcli device wifi rescan
sleep 2

# 2. Get List
# -t: Terse, -f: Fields. 
# awk: Deduplicates SSIDs and removes blanks
wifi_list=$(nmcli --colors no -t -f SSID device wifi list | awk '!seen[$0]++' | grep -v "^$")

# 3. Select Network
# WOFI FIX: use --dmenu, --prompt, and --lines (if needed, though wofi handles height auto mostly)
chosen_network=$(echo -e "$wifi_list" | wofi --dmenu --prompt "Network")

[ -z "$chosen_network" ] && exit

# 4. Connection Logic
# First, check if we already have a profile for this network
if nmcli -t -f NAME connection show | grep -qFx "$chosen_network"; then
    
    # Try to bring up the existing connection
    notify-send "Attempting to connect to saved network..."
    
    if nmcli connection up "$chosen_network"; then
        notify-send "Connected: \"$chosen_network\""
        exit 0
    else
        # IF SAVED CONNECTION FAILS (Wrong password, changed credentials)
        notify-send "Saved login failed. Retrying with password..."
        
        # Optional: Delete the bad profile so we can create a fresh one
        nmcli connection delete "$chosen_network"
    fi
fi

# 5. Password Prompt (Fallback or New Network)
# If we are here, either the network is new, OR the saved connection failed.
# WOFI FIX: use --password to mask input
wifi_password=$(wofi --dmenu --prompt "Password" --password)

if [ -n "$wifi_password" ]; then
    nmcli device wifi connect "$chosen_network" password "$wifi_password" && notify-send "Connected: \"$chosen_network\""
else
    # No password provided? Try connecting open.
    nmcli device wifi connect "$chosen_network" && notify-send "Connected: \"$chosen_network\""
fi
