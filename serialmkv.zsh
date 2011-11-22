#!/bin/zsh

SUFFIX=$1

if [ $# != 1 ]
then
	print "This expects a suffix. Example: "$0" avi"
	exit 1
fi

if [ "$SUFFIX" = "flv" -o "$SUFFIX" = "wmv" ]
then
	for n in *.$SUFFIX; ffmpeg -acodec copy -vcodec copy -i $n $n:r.mkv
else
	for n in *.$SUFFIX; mkvmerge -o $n:r.mkv $n
fi
