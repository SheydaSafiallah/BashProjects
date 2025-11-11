#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

echo -e "\n Disk Usage Report for: $DIR\n"

du -sb "$DIR"/* | sort -nr | awk '

BEGIN {
    max_bar = 50
    red="\033[1;31m"
    yellow="\033[1;33m"
    green="\033[1;32m"
    blue="\033[1;34m"
    reset="\033[0m"
}
{
    size_bytes[NR] = $1
    path[NR] = $2
}
END {

    max_size = 0
    for(i=1;i<=NR;i++) if(size_bytes[i]>max_size) max_size=size_bytes[i]

    for(i=1;i<=NR;i++){
        bar_len = int(size_bytes[i]/max_size * max_bar)
        if(bar_len < 1 && size_bytes[i] > 0) bar_len=1


        if(size_bytes[i] > max_size*0.75) color = red
        else if(size_bytes[i] > max_size*0.5) color = yellow
        else if(size_bytes[i] > max_size*0.25) color = green
        else color = blue


        split(path[i], arr, "/")
        name = arr[length(arr)]



        size_hr = size_bytes[i]
        if(size_hr >= 1073741824) size_hr = sprintf("%.2fG", size_hr/1073741824)
        else if(size_hr >= 1048576) size_hr = sprintf("%.2fM", size_hr/1048576)
        else if(size_hr >= 1024) size_hr = sprintf("%.2fK", size_hr/1024)
        else size_hr = size_hr "B"

        bar=""
        for(j=0;j<bar_len;j++) bar=bar "|"
            printf "%-25s %8s %s%s%s\n", name, size_hr, color, bar, reset
    }
}'


echo -e "\n Done!"
