#!/bin/bash
set -euo pipefail

cd ~/dotfiles/services/navidrome

sudo depotdownloader -app $1 -username villyp123 -dir "./music/$2"

cd "music/$2"

sudo find . -type f -iname '*.wav' -exec sh -c ' 
  for f do
    ffmpeg -nostdin -n -i "$f" -map_metadata 0 -c:a flac "${f%.*}.flac" &&
      rm -- "$f" || exit 1
  done
' sh {} + && sudo find . -type f -iname '*.mp3' -delete
