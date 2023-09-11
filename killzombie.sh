#!/bin/bash
# Shebang is used to indicate the shell used
# Function to find and kill zombie processes
kill_zombies() {
    zombies=$(ps -e -o pid,stat | awk '$2=="Z" { print $1 }')
    
    if [ -z "$zombies" ]; then
        echo "No zombie found"
    else
        echo "Killing the following zombie processes:"
        echo "$zombies"
        for pid in $zombies; do
            sudo kill -9 "$pid"
        done
        echo "Zombie processes eliminated"
    fi
}

# Call the function
kill_zombies
