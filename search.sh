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
  for (($show; $show < $loop; show=show+3)); do
    for ((i=0; i <= $show; i++)); do
        echo ${lines[$i]}
    done
    read 
    clear
  done
}

function start {
  clear
  getString "$key" "$filename"
  setShowLines
}

start