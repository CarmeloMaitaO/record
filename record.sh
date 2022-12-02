#!/bin/sh

dir="$XDG_VIDEOS_DIR/recordings"
name="$(date +%Y-%m-%d-%H:%M).mp4"
output="$dir/$name"
resolution=$(xrandr | awk '/\*/{print $1}')
signal='SIGINT'
title="Record.sh"
starting="Recording"
stopping="Stopping recording"
lockdir="$HOME/.local/state/record.sh"
lock="$lockdir/pid"

start () {
	echo $$ > $lock &
	notify-send $title $starting &
	guvcview -p default.gpfl -g none &
	ffmpeg -video_size $resolution -f x11grab -i :0.0+0,0 \
		-f pulse -ac 2 -i default $output &
}
stop () {
	rm $lock
	killall guvcview
	killall -s $signal ffmpeg && 
		notify-send $title $stopping
	killall record.sh
}

mkdir -p $lockdir
if test -e $lock
then stop
else start
fi
