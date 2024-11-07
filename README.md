# linux-bash-file-management

This repository contains Bash scripts for managing files based on size criteria. It includes logging of file movements and the ability to restore files to their original locations.

## Overview

The `linux-bash-file-management` suite enables users to move files based on a specified size threshold from an input directory to an output directory, logging each movement for easy restoration if needed. A dry-run option is available in both the move and restore scripts to preview actions without making changes.

## Features

- **File Movement**: Move files exceeding a specified size threshold.
- **Automatic Folder Creation**: Creates the output directory automatically if it does not exist.
- **Movement Logging**: Logs file movements for tracking and easy restoration.
- **File Restoration**: Restores moved files to their original locations using a dedicated script.
- **Dry Run Mode**: Preview file movements or restorations without making actual changes.

## Prerequisites

- Bash shell (Linux or macOS)
- Basic knowledge of command-line operations

## Usage

### Moving Files

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Jonahida/linux-bash-file-management.git
   cd linux-bash-file-management
   ```

2. **Make the move script executable, if not yet**:

   ```bash
   chmod +x move_files.sh
   ```

3. **Run the move script**:

   ```bash
./move_files.sh -i /path/to/input_folder -o /path/to/output_folder -s minimum_size [-d]
   ```
- `-i` or `--input`: Input folder containing files to be moved.
- `-o` or `--output`: Output folder where files will be moved.
- `-s` or `--size`: Minimum file size in bytes (positive integer).
- `-d` or `--dry-run`: Optional flag to preview files that would be moved without making actual changes.

   **Example**:

   ```bash
   ./move_files.sh -i /home/$USER/input -o /home/$USER/output -s 1000 -d
   ```

   **Note**: The `-d` flag shows the intended actions without actually moving files.

### Restoring Files

1. **Make the restore script executable, if not yet**:
   ```bash
   chmod +x restore_files.sh
   ```
2. **Run the restore script**:

   ```bash
   ./restore_files.sh -o /path/to/output_folder [-d]
   ```
- `-o` or `--output`: Output folder where files were previously moved.
- `-d` or `--dry-run`: Optional flag to preview files that would be restored without actually restoring them.

   **Example**:

   ```bash
   ./restore_files.sh -o /home/$USER/output -d
   ```

   **Note**: The `-d` flag shows the intended actions without actually restoring files.

## Contributing

Contributions are welcome! To contribute to this project:

- Fork the repository.
- Create a new branch for your feature or bug fix.
- Submit a pull request or open an issue to discuss any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
