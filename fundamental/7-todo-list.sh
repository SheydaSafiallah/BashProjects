#!/bin/bash

file="$HOME/todo.txt"
touch "$file"

while true; do
  echo "1) Add task"
  echo "2) Show tasks"
  echo "3) Exit"
  read choice

  case $choice in
    1)
      echo "Enter task:"
      read task
      echo "$task" >> "$file"
      ;;
    2)
      echo "Your tasks:"
      cat "$file"
      ;;
    3)
      echo "Goodbye!"
      break
      ;;
    *)
      echo "Invalid choice!"
      ;;
  esac
done
