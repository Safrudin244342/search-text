#!/bin/bash

key=$1
filename=$2
lines=()

function getString {
  filename=$2
  key=$1
  while read -r line; do
    lines[${#lines[@]}]=$line
  done < <(grep $filename -e "$key")
}

function setShowLines {
  if [ ${#lines[@]} -gt 5 ]; then
    show=5
  else
    show=1
  fi

  len=${#lines[@]}
  let "loop = len - show"
  for ((i=0; i < $show; i++)); do
    echo "=========================================="
    echo "Search for '$key' from '$filename'"
    echo "${lines[$i]}" | grep -0 "$key" --color -i
  done
  
  for ((i=$show; i < $loop; i++)); do
    read
    echo "=========================================="
    echo "Search for '$key' from '$filename'"
    echo "${lines[$i]}" | grep -0 "$key" --color -i
  done
}

function start {
  if [ -f "$filename" ]; then
    getString "$key" "$filename"
    if [ ${#lines[@]} = 0 ]; then
      echo "Tidak ditemukan kata yang tepat"
    else
      setShowLines
    fi
  else
    echo "$filename tidak ditemukan"
  fi
}

start
