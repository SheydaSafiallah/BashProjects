#!/bin/bash

echo "Welcome to the interactive backup script!"

read -p "Enter the path of the directory you want to back up: " src

if [ ! -d "$src" ]; then
  echo "Error: Source directory does not exist."
  exit 1
fi

read -p "Enter the path where you want to save the backup: " dest

mkdir -p "$dest"

filename="backup-$(date +%F).tar.gz"

tar -czf "$dest/$filename" -C "$(dirname "$src")" "$(basename "$src")"

echo "Backup of '$src' created successfully at '$dest/$filename'"
