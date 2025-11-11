#!/bin/bash

echo "Welcome to Git Helper!"
echo "Make sure you are inside a Git repository."

while true; do
    echo
    echo "Choose an action:"
    echo "1) git status"
    echo "2) git add"
    echo "3) git commit"
    echo "4) git push"
    echo "5) git pull"
    echo "6) git log"
    echo "7) Exit"
    read -p "Enter choice [1-7]: " choice

    case $choice in
        1)
            git status
            ;;
        2)
            read -p "Enter file(s) to add (or '.' for all): " files
            git add $files
            echo "Files added."
            ;;
        3)
            read -p "Enter commit message: " msg
            git commit -m "$msg"
            ;;
        4)
            read -p "Enter branch name to push (default: current branch): " branch
            branch=${branch:-$(git branch --show-current)}
            git push origin $branch
            ;;
        5)
            git pull
            ;;
        6)
            git log --oneline --graph --decorate --all
            ;;
        7)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice. Try again."
            ;;
    esac
done
