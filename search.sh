#!/bin/bash

key=$1
filename=$2
lines=()

function getString {
  filename=$2
  key=$1
  while read -r line; do
    lines[${#lines[@]}]="====================================="
    lines[${#lines[@]}]="Search for key '$key' from '$filename'"
    lines[${#lines[@]}]=$line
  done < <(grep $filename -e "$key")
}

function showLines {
  for ((i=0; i < ${#lines[@]}; i++)); do
    echo ${lines[$i]}
  done
}

function setShowLines {
  show=10
  len=${#lines[@]}
  let "loop = len - show"
  for (($show; $show < $loop; show++)); do
    while read -r line; do
      echo $line
    done < <(showLines | head -n$show)
    read 
    clear
    let show=show+1
  done
}

function start {
  clear
  getString "$key" "$filename"
  setShowLines
}

start