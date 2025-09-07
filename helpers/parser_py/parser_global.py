# This script requires the 'aiofiles' package. Install it with: pip install aiofiles

import asyncio
import json
import os
import shutil
from pathlib import Path
import aiofiles
from parser_utils import tokenize, process_tokens

# Load configuration files
config_path = Path(__file__).parent.parent
with open(config_path / 'parser' / 'skipFiles.json', 'r') as f:
    skip_files_config = json.load(f)
with open(config_path / 'parser' / 'paliWords.json', 'r') as f:
    pali_words = json.load(f)
with open(config_path / 'parser' / 'replaceCommands.json', 'r') as f:
    replace_commands = json.load(f)

# Pali-specific characters for detection
pali_indicators = ["ṭ", "ḍ", "ṅ", "ñ", "ṇ", "ṁ", "ṃ", "ā", "ī", "ū", "ś", "ṣ"]
pali_indicators += [c.upper() for c in pali_indicators]

def get_all_files(dir_path):
    files = []
    for entry in os.scandir(dir_path):
        full_path = Path(entry.path)
        relative_path = full_path.relative_to(dir_path)

        if entry.is_dir():
            if entry.name in skip_files_config or str(relative_path) in skip_files_config:
                continue
            files.extend(get_all_files(full_path))
        elif entry.is_file():
            text_extensions = ['.txt', '.tex', '.md', '.html', '.xml', '.json', '.csv']
            if (entry.name not in skip_files_config and 
                str(relative_path) not in skip_files_config and 
                (full_path.suffix.lower() in text_extensions or not full_path.suffix)):
                files.append(full_path)
    return files

def fix_latex_commands(line):
    for wrong, correct in replace_commands.items():
        line = line.replace(wrong, correct)
    return line

def contains_pali_text(line):
    if any(indicator in line for indicator in pali_indicators):
        return True
    lower_line = line.lower()
    if any(word.lower() in lower_line for word in pali_words):
        return True
    return False

async def process_file(file_path, create_backup, heavy_end, use_x_below):
    try:
        async with aiofiles.open(file_path, 'r', encoding='utf-8') as f:
            content = await f.read()
    except Exception:
        # Fallback for non-utf8 files
        async with aiofiles.open(file_path, 'r', encoding='latin-1') as f:
            content = await f.read()

    lines = content.split('\n')
    has_changes = False
    has_pali_content = False

    processed_lines = []
    for line in lines:
        if line.strip().startswith('\\') or line.strip().startswith('{'):
            processed_lines.append(line)
            continue

        if contains_pali_text(line):
            has_pali_content = True
            original_line = line
            

            tokens = tokenize(processed_line)
            processed_tokens = process_tokens(tokens, heavy_end, use_x_below)
            processed_line = fix_latex_commands(line)
            processed_line = "".join(processed_tokens)

            if original_line != processed_line:
                has_changes = True
            processed_lines.append(processed_line)
        else:
            processed_lines.append(line)

    if has_pali_content and has_changes:
        if create_backup:
            shutil.copy(file_path, str(file_path) + '.bak')
        
        async with aiofiles.open(file_path, 'w', encoding='utf-8') as f:
            await f.write('\n'.join(processed_lines))
        return True
    return False

async def main():
    dir_path_str = input('Enter the directory path to process recursively: ')
    dir_path = Path(dir_path_str)

    if not dir_path.is_dir():
        print(f"Error: Directory not found at '{dir_path_str}'")
        return

    create_backup_str = input('Create backup files? (y/n): ').lower()
    should_backup = create_backup_str == 'y'

    heavy_end_str = input('Do you want to use end heavy? (y/n): ').lower()
    heavy_end = heavy_end_str == 'y'

    use_x_below = False
    if heavy_end:
        use_x_below_str = input('Do you want to mark them with x below? (y/n): ').lower()
        use_x_below = use_x_below_str == 'y'

    print("\nStarting processing...")
    files = get_all_files(dir_path)
    processed_count = 0
    skipped_count = 0

    for file in files:
        try:
            processed = await process_file(file, should_backup, heavy_end, use_x_below)
            if processed:
                processed_count += 1
                print(f"✓ Processed: {file}")
            else:
                skipped_count += 1
                print(f"- Skipped (no Pali content or no changes): {file}")
        except Exception as e:
            print(f"✗ Error processing {file}: {e}")

    print(f"\nSummary: {processed_count} files processed, {skipped_count} files skipped")

if __name__ == "__main__":
    asyncio.run(main())
