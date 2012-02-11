#!/bin/zsh

setopt extendedglob

targets=( avi mkv mp4 mov )

typeset -A archives
archives=( rar 'unrar x'
           zip 'unzip'
           7z  '7z x' )

if [ -z $TR_TORRENT_DIR ]; then
  TARGET_DIR="/tmp"
else
  TARGET_DIR=$TR_TORRENT_DIR"/.."
fi

if [ -d $TR_TORRENT_DIR ]; then
  cd $TR_TORRENT_DIR
fi
if [ -d $TR_TORRENT_NAME ]; then
  cd $TR_TORRENT_NAME
fi

original_files=( *(Om) )

# unpack
for archive in ${(k)archives}; do
  archive_files=( *.$archive(N) )
  if (( $#archive_files )); then
    for n in *.$archive; eval $archives[$archive] $n
  fi
done

all_files=( *(Om) )

# handle targets
(( count_new = $#all_files - $#original_files ))
if [[ count_new == 0 ]]; then
  # Seems nothing was extracted, create links for stuff we care about
  for target in $targets; do
    target_files=( (#i)**/*.$target~sample(N) )
    if (( $#target_files )); then
      for n in *.$target; ln $n $TARGET_DIR/$n
    fi
  done
elif [[ count_new > 0 ]]; then
  new_files=$all_files[0,$count_new]
  for n in $new_files; mv $n $TARGET_DIR
else exit 1
fi

exit 0
