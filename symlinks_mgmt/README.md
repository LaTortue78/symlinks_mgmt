# Symlinks Management Tool

This project provides a Bash script for managing and comparing symbolic links in a file system. The main script, `compare_symlinks.sh`, allows users to compare two files containing symbolic links and their targets, providing a clear output of any differences.

## Purpose

The purpose of this tool is to help users easily identify changes in symbolic links over time, making it useful for system administrators and developers who need to maintain consistent link structures.

## Usage

To use the `compare_symlinks.sh` script, follow these steps:

1. Prepare two text files containing symbolic links and their targets. The format should be:
   ```
   link ➜ target
   ```
   For example:
   ```
   /path/to/link1 ➜ /path/to/target1
   /path/to/link2 ➜ /path/to/target2
   ```

2. Run the script with the two files as arguments:
   ```bash
   ./compare_symlinks.sh file1.txt file2.txt
   ```

3. The script will output the comparison results, indicating whether links are identical, modified, deleted, or newly added.

## Continuous Integration

This project includes a GitHub Actions workflow defined in `.github/workflows/ci.yml` to automatically test the Bash scripts on each push or pull request. This ensures that any changes to the scripts are validated and that they function as expected.

## Requirements

- Bash shell
- Access to the command line
- Basic understanding of symbolic links in Unix-like systems

## License

This project is licensed under the MIT License. See the LICENSE file for more details.