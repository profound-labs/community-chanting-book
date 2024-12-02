#!/usr/bin/env python3

import sys
import re
from typing import List, TypedDict
from pathlib import Path
import unicodedata

def remove_accents(text: str) -> str:
    """
    Remove accents from a string by mapping accented characters to their non-accented Latin versions.
    """
    # Normalize the string to decompose accented characters
    nfkd_form = unicodedata.normalize('NFKD', text)

    # Filter out diacritical marks
    filtered_string = ''.join([c for c in nfkd_form if not unicodedata.combining(c)])

    return filtered_string

def id_from_title(title: str) -> str:
    id = re.sub(r'[^a-zA-Z]', '-', remove_accents(title.lower()))
    return id

class FirstLineData(TypedDict):
    first_line: str
    chant_title: str
    file_path: Path

def first_lines_from_tex_files(tex_files: List[Path]) -> List[FirstLineData]:
    first_lines: List[FirstLineData] = []

    for tex_path in tex_files:
        tex_content = ""
        with open(tex_path, 'r', encoding="utf-8") as f:
            tex_content = f.read()

        for m in re.finditer(r'^\\chapter(.*?){([^}]+)}\n+\\firstline{(.*?)}', tex_content, re.MULTILINE|re.DOTALL):
            first_lines.append(
                FirstLineData(
                    first_line = m.group(3),
                    chant_title = m.group(2),
                    file_path = tex_path,
                )
            )

    return first_lines

def first_lines_as_links(first_lines: List[FirstLineData]) -> List[str]:
    ret = []
    for i in first_lines:
        href = i['file_path'].stem
        id = id_from_title(i['chant_title'])
        label = i['first_line']
        ret.append(f"""<a href="{href}.html#{id}">{label}</a>""")
    return ret

if __name__ == "__main__":
    files = sys.argv[1:]
    tex_files = [Path(x) for x in files if Path(x).suffix == ".tex"]

    first_lines = first_lines_from_tex_files(tex_files)
    first_lines = sorted(first_lines, key=lambda x: x['first_line'])

    print("\n".join(first_lines_as_links(first_lines)))
