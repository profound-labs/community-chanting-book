#!/usr/bin/env python3

import sys
import re
import unicodedata
from typing import Match, List

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

def add_toc(markdown: str) -> str:
    # Add header ids
    # collect a list to check for duplicates
    ids: List[str] = []

    def _add_anchor(m: Match[str]) -> str:
        title = m.group(1)

        id = id_from_title(title)

        n = 0
        while id in ids:
            n += 1
            id = id + "-" + str(n)

        anchor = f"""<a id="{id}"></a>"""
        ids.append(id)

        # NOTE: doesn't work for some reason
        # s = m.group(0)
        # ret = s[:m.start(1)] + title + anchor + s[m.end(1):]
        # So manually reconstructing the match parts:
        ret = "## " + title + anchor

        return ret

    s = re.sub(r'^## (.*)', lambda x: _add_anchor(x), markdown, flags=re.MULTILINE)

    headers = []
    for m in re.finditer(r'^## (.*?)<a id="([^"]+)"></a>', s, flags=re.MULTILINE):
        item = f'- [{m.group(1)}](#{m.group(2)})'
        headers.append(item)

    toc_list = "\n".join(headers)

    s = toc_list + "\n\n" + s

    return s

def convert_tex_to_md(tex_path: str, md_path: str, title: str):
    s = ""

    with open(tex_path, 'r', encoding='utf-8') as f:
        s = f.read()

    # String spaces but ensure newlines to help regex matches
    s = "\n\n" + s.strip() + "\n\n"

    # remove comments
    s = re.sub(r'%.*', '', s)

    # remove ignored LaTeX commands
    s = re.sub(r'\n *\\ifaivedition\n *\\clearpage\n *\\fi\n+', r'\n', s)
    s = re.sub(r'\n *\\ifaivedition\\relax\\else\n *\\clearpage\n *\\fi\n+', r'\n', s)

    s = re.sub(r'\\relax\n', r'\n', s)
    s = re.sub(r'\n+\\vfill\n+', r'\n\n', s)
    s = re.sub(r'\n+\\clearpage\n+', r'\n\n', s)
    s = re.sub(r'\n+\\cleartoverso\n+', r'\n\n', s)
    s = re.sub(r'\\centering *', '', s)
    s = re.sub(r'\n+\\artopttrue\n+', r'\n\n', s)
    s = re.sub(r'\n+\\artoptfalse\n+', r'\n\n', s)
    s = re.sub(r'\n+\\savenotes\n+', r'\n\n', s)
    s = re.sub(r'\n+\\spewnotes\n+', r'\n\n', s)
    s = re.sub(r'\n+\\paliText\n+', r'\n\n', s)
    s = re.sub(r'\n+\\englishText\n+', r'\n\n', s)
    s = re.sub(r'\n+\\resumeNormalText\n+', r'\n\n', s)
    s = re.sub(r'\n+\\chapterTocSubIndentTrue\n+', r'\n\n', s)
    s = re.sub(r'\n+\\chapterTocDelegatePageNumber\n+', r'\n\n', s)
    s = re.sub(r'\n+\\setTocDelegatedPageNumber\n+', r'\n\n', s)
    s = re.sub(r'\n+\\setEnglishTextSize\{[0-9]+\}\{[0-9]+\}\{[^}]+\}\n+', r'\n\n', s)

    s = re.sub(r'\n+\\nextChapterUseDelegatedPageNumber\n+', r'\n\n', s)
    s = re.sub(r'\n+\\delegateSetUseNext\n+', r'\n\n', s)
    s = re.sub(r'\n+\\setArrayStrech{[^}]+}\n+', r'\n\n', s)
    s = re.sub(r'\n+\\restoreArrayStretch\n+', r'\n\n', s)

    s = re.sub(r' *\\protect *', r'', s)

    s = re.sub(r'\\vspace\**{[^}]+}', r'', s)
    s = re.sub(r'\\hspace\**{[^}]+}', r'', s)
    s = re.sub(r'\n+\\enlargethispage\**{[^}]+}\n+', r'\n\n', s)
    s = re.sub(r'\n+\\firstline{[^}]+}\n+\\firstline{[^}]+}\n+', r'\n\n', s)
    s = re.sub(r'\n+\\firstline{[^}]+}\n+', r'\n\n', s)

    s = re.sub(r'\\addtocontents\{toc\}\{\n+\}\n', r'\n', s)

    s = re.sub(r'\n+\\setlength{[^}]+}{[^}]+}\n+', r'\n\n', s)

    s = re.sub(r'^[{}]$', '', s, flags=re.MULTILINE)

    # headings
    s = re.sub(r'\\chapter\**{([^}]+?)}', r'## \1', s)
    s = re.sub(r'\\chapter\**(.*?){([^}]+?)}', r'## \2', s)

    s = re.sub(r'^## (.*?)\\newline', r'## \1', s, flags=re.MULTILINE)

    s = re.sub(r'\\section\**{([^}]+?)}', r'### \1', s)
    s = re.sub(r'\\section\**(.*?){([^}]+?)}', r'### \2', s)

    # line breaks
    s = re.sub(r'\\\\\n', r'\\\n', s)
    s = re.sub(r'\\\\', r'\\\n', s)

    # dashes
    # NOTE: r'\b---\b' does not work, perhaps because - is already a word boundary?
    s = re.sub(r'---', '—', s)
    s = re.sub(r'--', '–', s)

    # inline formatting
    s = re.sub(r'\\instr{([^}]+)}', r'**[ \1 ]**', s)
    s = re.sub(r'\\soloinstr{([^}]+)}', r'**[ \1 ]**', s)
    s = re.sub(r'\\prul{([^}]+)}', r'<span class="prul">\1</span>', s)
    s = re.sub(r'\\(emph|textit){([^}]+)}', r'*\2*', s)
    s = re.sub(r'\\tr{([^}]+)}', r'<em>\1</em>', s)
    s = re.sub(r'\\sidepar{([^}]+)}', r'**(\1)** ', s)
    s = re.sub(r'\\ldots{}', '...', s)
    s = re.sub(r'\\hyp{}', '-', s)
    s = re.sub(r'\\&', r'&amp;', s)
    s = re.sub('~', ' ', s)
    s = re.sub('`', "'", s)

    s = re.sub(r'\\trline{(.*)?}', r'<div class="english">\n\n> \1\n\n</div>', s)

    # s = re.sub(r'\\vin +', r'<span class="vin"></span>', s)

    # remove line breaks and indentation, allow text to re-flow
    s = re.sub(r'\\\n*\\vin +', r' ', s)

    # Paritta and onechants: regular paragraphs
    s = s.replace(r'\begin{paritta}', '')
    s = s.replace(r'\end{paritta}', '')
    s = s.replace(r'\begin{onechants}', '')
    s = s.replace(r'\end{onechants}', '')

    # text environments to div classes
    while True:
        m = re.search(r'\n+\\begin{(twochants|solotwochants)}\n+(.*?)\n+\\end{(twochants|solotwochants)}\n+',
                      s,
                      flags=re.MULTILINE|re.DOTALL)
        if m:
            content = m.group(2)

            # the line break \\ has already been converted to \
            content = re.sub(r'^ *(.*?) *& *(.*?) *(\\?)$', r'\n\n\1 \2\n\n', content, flags=re.MULTILINE)

            s = s[:m.start(0)] + "\n\n" + content + "\n\n" + s[m.end(0):]
        else:
            break

    while True:
        m = re.search(r'\n+\\begin{(english|leader|instruction|soloonechants)}\n+(.*?)\n+\\end{(english|leader|instruction|soloonechants)}\n+',
                      s,
                      flags=re.MULTILINE|re.DOTALL)
        if m:
            name = m.group(1)
            content = m.group(2)

            # put content in a block quote
            if name == "instruction":
                content = "> [ " + content.strip() + " ]"
            else:
                content = "> " + content.strip()

            content = re.sub(r'\n *(.+?)$', r'\n> \1', content, flags=re.MULTILINE)

            html_block = f"""\n\n<div class="{name}">\n\n{content}\n\n</div>\n\n"""

            s = s[:m.start(0)] + html_block + s[m.end(0):]
        else:
            break

    while True:
        m = re.search(r'\n+\\begin{tabular}{ r l }\n+(.*?)\n+\\end{tabular}\n+',
                      s,
                      flags=re.MULTILINE|re.DOTALL)
        if m:
            content = m.group(1)

            content = re.sub(r'^ *(.*?) *& *(.*?) *\\', r'<tr><td>\1</td><td>&#x2003;</td><td>\2</td></tr>', content, flags=re.MULTILINE)

            content = '<table class="middle-aligned">\n' + content + '\n</table>'

            s = s[:m.start(0)] + "\n\n" + content + "\n\n" + s[m.end(0):]
        else:
            break

    while True:
        m = re.search(r'\n+\\begin{precept}\n+(.*?)\n+\\end{precept}\n+',
                      s,
                      flags=re.MULTILINE|re.DOTALL)
        if m:
            content = m.group(1)

            def _num(x: Match):
                num_match = x.group(1)
                n = int(num_match)
                n += 1
                return f"({n}) "

            content = re.sub(r'^ *\\setcounter{enumi}{([0-9])} *\n *\\item *', lambda x: _num(x), content, flags=re.MULTILINE)

            s = s[:m.start(0)] + "\n\n" + content + "\n\n" + s[m.end(0):]
        else:
            break

    # remove double blanks
    s = re.sub(r'\n\n\n+', r'\n\n', s)

    s = s.strip()

    s = add_toc(s)

    # Add the chapter title
    s = f"# {title}\n\n" + s

    # find and warn about unconverted LaTeX commands
    for m in re.finditer(r'[^\n ]*[{}][^\n ]*', s):
        print("WARN Unconverted LaTeX: " + m.group(0))
    for m in re.finditer(r'\\[^\n ]+', s):
        print("WARN Unconverted LaTeX: " + m.group(0))

    with open(md_path, 'w', encoding='utf-8') as f:
        f.write(s)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: tex_to_md.py <input.tex> <output.md> <title>")
        sys.exit(-1)

    convert_tex_to_md(sys.argv[1], sys.argv[2], sys.argv[3])
