#!/bin/bash

username="navinate"
current_dir=$(basename "$PWD")
echo "Current directory name: $current_dir"

echo "Enter project target:"
read target

echo "Enter version:"
read version

if [[ $target == "all" ]]; then
  for dir in */; do
      # Check if it's a directory
      if [ -d "$dir" ] && [ "$dir" != "zips/" ]; then
          target_file=./zips/${dir%/}_${version}.zip
          7z a -r $target_file ${dir%/}/*
          butler push $target_file $username/$target --userversion $version
      fi
  done
else
  if [ -d "$target" ]; then
    target_file=./zips/${target}_${version}.zip
    7z a -r target_file $target/*
    butler push target_file $username/$target --userversion $version
  else
    echo "Directory not found"
  fi
fi
echo "Finished uploading selected builds to itch.io"
