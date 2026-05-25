#!/bin/bash

# searchdata.sh
# This script prompts the user for a filename, verifies its existence, 
# and searches for a specific text string within it using 'grep'.

# Prompt the user to enter the file name
read -p "Enter the name of the file to search: " file

# Check if the file exists using the -f flag
if [ -f "$file" ]; then
    # Prompt user for the text search criteria
    read -p "Enter the text to search for inside the file: " text
    
    # Use grep to find matching lines case-insensitively and output them to pattern.txt
    grep -i "$text" "$file" > pattern.txt
    
    echo "Search complete. Results have been saved to pattern.txt"
else
    # Output an error message if the file doesn't exist
    echo "File not found"
fi
