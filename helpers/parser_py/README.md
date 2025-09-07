# Pali Text Parser Scripts

This directory contains Python scripts for processing text files containing Pali words. The scripts identify Pali text and apply phonetic markings.

This work is a Python adaptation of a Node.js script found in the parent directory, as requested, all made in gemini-cli (including that README)

## Scripts

### `parser_global.py`

This is the main script for recursively processing a directory of text files. It identifies files containing Pali text and applies the necessary phonetic markings.

**Usage:**

1.  Run the script from your terminal:
    ```bash
    python parser_global.py
    ```
2.  The script will prompt you for the following information:
    *   The directory path to process recursively.
    *   Whether to create backup files (`.bak`) for the processed files.
    *   Whether to use "end heavy" processing.
    *   If using "end heavy", whether to mark the heavy syllables with an "x" below.

### `parser.py`

This script processes a single text file and saves the output to a new file. It is less used than `parser_global.py` but can be useful for testing or processing individual files.

**Usage:**

```bash
python parser.py <input_file> <output_file> [--heavy-end] [--x-below]
```

### `parser_utils.py`

This is a utility module that contains the core logic for tokenizing and processing Pali text. It is used by both `parser_global.py` and `parser.py`.

## Configuration

The scripts use configuration files located in the `parser` directory (a sibling to the `helpers` directory):

*   `skipFiles.json`: A list of files and directories to skip during processing.
*   `paliWords.json`: A list of Pali words to help with text identification.
*   `replaceCommands.json`: A set of rules for correcting common LaTeX command mistakes.
