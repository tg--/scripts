#!/bin/zsh
# This script plays a random episode from a tv show on your disk
# just call it with a shows name as parameter (name doesn't have to be complete)
# and for extra arguments for your player pass them after --
# e.g. rsplay.zsh Simpsons -- -fs

## settings
# the location of all shows
location=~/serien

# your favorite movie player
player=mplayer

# extra parameters for your player
#player_params=(-fs -nosound)

# internal variables
name=$1
dirs=()
files=()
extra_args=${(z)"${*}"#*--}

setopt extendedglob

function all_random()
{
	dirs=($location/*(/))
	files=($dirs[$RANDOM%$#dirs+1]/**/*(.))
}

if [[ ! -d $location ]]; then
	print "$location not found, please fix your configuration."
	return 1
fi

if [[ ! -d $location/$name ]]; then
	print "$name not found, guessing..."
	name=$(print $location/(#i)*$name*([1,1]))

	if [[ ! -d $name ]]; then
		print "Couldn't guess either, just playing something."
		all_random
	else
		print "Guessed: $name"
		files=($name/**/*(.))
	fi
elif [[ -z $name ]]; then
	print "No name given, picking at random."
	all_random
else
	files=($location/$name/**/*(.))
fi

$player $extra_args $player_params $files[$RANDOM%$#files+1]
