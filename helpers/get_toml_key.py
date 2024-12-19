#!/usr/bin/env python3

import sys
import tomllib

def main():
    if len(sys.argv) != 3:
        print("Usage: get_toml_key.py <toml_file_path> <key>")
        sys.exit(1)

    toml_file_path = sys.argv[1]
    key_to_extract = sys.argv[2]

    try:
        # Open and read the TOML file
        with open(toml_file_path, "rb") as f:
            toml_data = tomllib.load(f)

        # Extract the value
        def get_nested_value(data, key):
            key_parts = key.split('.')
            current = data
            for part in key_parts:
                if isinstance(current, dict) and part in current:
                    current = current[part]
                else:
                    raise KeyError(f"Key '{key}' not found")
            return current

        try:
            extracted_value = get_nested_value(toml_data, key_to_extract)
            print(extracted_value)
        except KeyError:
            print(f"Key '{key_to_extract}' not found in the TOML file")
            sys.exit(1)

    except FileNotFoundError:
        print(f"TOML file '{toml_file_path}' not found")
        sys.exit(1)
    except tomllib.TOMLDecodeError:
        print(f"Invalid TOML in file '{toml_file_path}'")
        sys.exit(1)

if __name__ == "__main__":
    main()
