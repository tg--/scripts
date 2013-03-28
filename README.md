# Scripts

This repo contains some of my personal scripts,
feel free to use them however you like.
Complex scripts may include a license header,
if not (or if script is trivial) consider it public domain.

## Available Scripts

### gajim_autoanswer.py
This tiny python script searches for a series of words in a gajim message
from a certain person and automatically answers if found.
It uses gajim-remote to answer where dbus should be used directly,
but it only is supposed to show a friend how easy this can be :)

### rsplay.zsh
This script plays a _R_andom _S_eries episode with minimal effort.
See description in the script for details.

### serialmkv.zsh
This trivial zsh script will try to convert each file with a specified suffix
to a matroska (mkv) file, so it likely will be used for video files.
Requires at least mkvmerge, or for some filetypes (as of now: wmv, flv) ffmpeg.

### tr_finish_torrent.zsh
This zsh script can be run by transmission when a torrent is finished.
It will unpack supported archives, and move their content to a target dir,
or hardlink supported files to a target dir,
so the files can be used for whatever needed while the seeding can go on.

### tvseries_rename.bash (deprecated!)
This bash script will take the name of a tv show, the number of a season and the filetype
to rename all episodes of that season in a folder with their full names.
It will pull them from IMDB and look for the pattern E$NUMBER to rename the files.

Attention: This script is a huge mess, pending a rewrite in a proper language (python probably)!
However, it works reasonably well, and probably won't destroy your computer, so feel free to use it :)
Run the script with --help as parameter for more information.

This script is deprecated because IMDB changed their generated code once again.
It is currently unmaintained, but might work with minimal changes.
