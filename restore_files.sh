#!/bin/bash

# Function to show help
function show_help {
    echo "Usage: $0 -o <output_folder> [-d]"
    echo "  -o, --output     Output folder where files were moved."
    echo "  -d, --dry-run    Show files that would be restored without restoring them."
    exit 1
}

# Default to regular mode (not dry run)
dry_run=false

# Check if the script is executed without arguments
if [ "$#" -eq 0 ]; then
    show_help
fi

# Process command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -o|--output) output_folder="$2"; shift ;;
        -d|--dry-run) dry_run=true ;;
        *) echo "Unknown option: $1"; show_help ;;
    esac
    shift
done

# Check that the output folder is defined
if [[ -z "$output_folder" ]]; then
    echo "Output folder is required."
    show_help
fi

# Log file for restoration
log_file="$output_folder/movements.log"

# Check if the log file exists
if [[ ! -f "$log_file" ]]; then
    echo "Log file not found in $output_folder. Cannot restore files."
    exit 1
fi

# Restore files based on the log
while IFS= read -r line; do
    # Use regular expressions to extract original and destination paths
    if [[ "$line" =~ Moved:\ (.*)\ \-\>\ (.*)\ \-\ Size ]]; then
        original_path="${BASH_REMATCH[1]}"
        destination_path="${BASH_REMATCH[2]}"

        # Check if the destination file exists
        if [[ -e "$destination_path" ]]; then
            if $dry_run; then
                echo "Dry run: Would restore $destination_path to $original_path"
            else
                mv "$destination_path" "$original_path"
                echo "Restored: $original_path"
            fi
        else
            echo "File not found for restoration: $destination_path"
        fi
    else
        echo "Log entry format incorrect: $line"
    fi
done < "$log_file"

if $dry_run; then
    echo "Dry run complete. No files restored."
else
    echo "Files restored from $output_folder."
fi
