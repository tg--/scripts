#!/bin/zsh

# Supported Suffixes
file_suffixes=(avi mkv mp4 mov)

# Supported Archives
typeset -A comp_suffixes
comp_suffixes=( rar 'unrar x'
                zip 'unzip'
                7z  '7z x'
              )

# Set some paths
if [ -z $TR_TORRENT_DIR ]; then
  TARGET_DIR="/tmp"
else TARGET_DIR=$TR_TORRENT_DIR"/.."
fi

cd $TR_TORRENT_DIR
if [ -d $TR_TORRENT_NAME ]; then
  cd $TR_TORRENT_NAME
fi

# save snapshot of files before extract
orig_files=(*(Om))

# do some unpacking
for CS in ${(k)comp_suffixes}; do
  CS_files=( *.$CS(N) )
  if (( $#CS_files )); then
    for n in *.$CS; eval $comp_suffixes[$CS] $n
  fi
done

all_files=(*(Om))
(( count_new = $#all_files - $#orig_files ))
if [[ count_new == 0 ]]; then
  # Seems nothing was extracted, let's create links for stuff we care about
  for FS in $file_suffixes; do
    FS_files=( (#i)**/*.$FS~*sample*(N) )
    if (( $#FS_files )); then
      for n in *.$FS; ln $n $TARGET_DIR/$n
    fi
  done
elif [[ count_new > 0 ]]; then
  # Move all new files to target
  new_files=$all_files[0,$count_new]
  for n in $new_files; mv $n $TARGET_DIR/
else exit 1 # Something's terribly wrong, better get out of here!
fi

exit 0
