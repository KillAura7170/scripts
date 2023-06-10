#! /bin/bash

dte(){
	dte="$(date '+%Y %b %d (%a) %I:%M%p')"
	echo -e "$dte"
}

bat() {
	bat="$(cat /sys/class/power_supply/BAT0/capacity)"
	case "$(cat "/sys/class/power_supply/BAT0/status" 2>&1)" in
		"Full") status="FULL" ;;
		"Discharging") status="" ;;
		"Charging") status="⚡" ;;
		"Not charging") status="" ;;
		"Unknown") status="" ;;
		*) exit 1 ;;
	esac
	echo -e "$bat% $status"
}

WiFi() {
	WiFi="$(cat /sys/class/net/wlp2s0/operstate)"
	echo -e "$WiFi"
}

Vol() {
	vol="$(amixer sget Master | awk -F"[][]" '/%/ { if ($6 == "off") print 0; else print $2 }' | head -n1)"
	echo -e "$vol"
}

Tmp() {
	tmp="$(cat /sys/class/thermal/thermal_zone0/temp | sed 's/[0].0$//')"
	echo -e "$tmp"
}

while true; do
	dwm -s "📶: $(WiFi) | 🔋: $(bat) | 🔊: $(Vol) | 🌡: $(Tmp)°C | $(dte)"
	sleep 10s
done &
