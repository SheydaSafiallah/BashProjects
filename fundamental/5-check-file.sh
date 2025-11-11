#!/bin/bash

echo "Enter a file name:"
read file

if [ -e "$file" ]; then
  echo "File exists."
else
  echo "File does not exist. Creating it..."
  touch "$file"
fi
