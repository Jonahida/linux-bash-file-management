#!/bin/bash

# Function to show help
function show_help {
    echo "Usage: $0 -i <input_folder> -o <output_folder> -s <min_size>"
    echo "  -i, --input      Input folder to search for files."
    echo "  -o, --output     Output folder to move the files."
    echo "  -s, --size       Minimum file size in bytes (positive integer)."
    echo "  -d, --dry-run    Show files that would be moved without moving them."
    exit 1
}

# Default to regular mode (not dry run)
dry_run=false

# Process command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--input) input_folder="$2"; shift ;;
        -o|--output) output_folder="$2"; shift ;;
        -s|--size) min_size="$2"; shift ;;
        -d|--dry-run) dry_run=true ;;
        *) echo "Unknown option: $1"; show_help ;;
    esac
    shift
done

# Check that required parameters are defined
if [[ -z "$input_folder" || -z "$output_folder" || -z "$min_size" ]]; then
    echo "All parameters are required."
    show_help
fi

# Validate minimum size as a positive integer
if ! [[ "$min_size" =~ ^[0-9]+$ ]] || [[ "$min_size" -le 0 ]]; then
    echo "Error: Minimum size must be a positive integer."
    exit 1
fi

# Check if input folder exists
if [[ ! -d "$input_folder" ]]; then
    echo "Error: Input folder does not exist."
    exit 1
fi

# Create the output folder if it doesn't exist
mkdir -p "$output_folder"

# Log file for restoration
log_file="$output_folder/movements.log"

# Clear the log file if it exists
> "$log_file"

# Find and move files recursively
find "$input_folder" -type f -size +"${min_size}c" | while read -r file; do
    if [[ -e "$file" ]]; then
        destination="$output_folder/$(basename "$file")"
        if $dry_run; then
            echo "Dry run: Would move $file to $destination"
        else
            mv "$file" "$destination"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Moved: $file -> $destination - Size: $(stat -c%s "$destination") bytes" >> "$log_file"
        fi
    fi
done

if $dry_run; then
    echo "Dry run complete. No files moved."
else
    echo "Files moved. Logs saved in $log_file."
fi
