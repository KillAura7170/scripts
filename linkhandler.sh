#!/bin/sh

if [ -z "$1" ]; then
	url="$(xclip -o)"
else
	url="$1"
fi

case "$url" in
	*mkv|*webm|*mp4|*rumble.com*|*youtube.com/watch*|*youtube.com/playlist*|*youtube.com/shorts*|*youtu.be*|*hooktube.com*|*bitchute.com*|*videos.lukesmith.xyz*|*odysee.com*)
		setsid -f mpv -quiet "$url" >/dev/null 2>&1 ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && sxiv -a "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*pdf|*cbz|*cbr)
		curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && zathura "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*mp3|*flac|*opus|*mp3?source*)
		qndl "$url" 'curl -LO'  >/dev/null 2>&1 ;;
	*)
		[ -f "$url" ] && setsid -f "$TERMINAL" -e "$EDITOR" "$url" >/dev/null 2>&1 || setsid -f "$BROWSER" "$url" >/dev/null 2>&1
esac
