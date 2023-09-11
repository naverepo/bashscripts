#!/bin/bash

# Define the directory to start the search (root directory for the whole file system).
start_dir="/"

# Define the output file name and path.
output_file="biggest_files.txt"

# Use the 'find' command to search for files, sort them by size (largest first), and limit the output to the top 10.
sudo find "$start_dir" -type f -exec du -h {} + | sort -rh | head -n 10 > "$output_file"

echo "Top 10 biggest files in the file system have been written to '$output_file'."
