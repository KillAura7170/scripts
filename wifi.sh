#! /bin/bash

bssid=$(nmcli d wifi list | sed -n '1!p' | cut -b 9- | dmenu -p "Select WiFi: " -l 20 | cut -d' ' -f1)
pass=$(echo "" | dmenu -p "Enter Password: ")
nmcli d wifi connect $bssid password $pass
bssid=$(echo "")
pass=$(echo "")
