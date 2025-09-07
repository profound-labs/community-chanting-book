digraphs = ["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"] + [c.upper() for c in ["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"]]

vowels = ["a", "i", "u", "e", "ā", "ī", "ū", "o"] + [v.upper() for v in ["a", "i", "u", "e", "ā", "ī", "ū", "o"]]

long = ["e", "ā", "ī", "ū", "o"] + [l.upper() for l in ["e", "ā", "ī", "ū", "o"]]

short = ["a", "i", "u"] + [s.upper() for s in ["a", "i", "u"]]

consonants = [
  "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
  "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s", "ṁ", "ṃ"
] + [c.upper() for c in [
    "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
    "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s", "ṁ", "ṃ"
]] + ["Kh", "Ch", "Ṭh", "Th", "Ph", "Gh", "Jh", "Ḍh", "Dh", "Bh"]

def tokenize(line):
    tokens = []
    i = 0
    while i < len(line):
        char = line[i]
        if char in digraphs and i + 1 < len(line) and line[i + 1] == 'h':
            tokens.append(char + 'h')
            i += 2
        else:
            tokens.append(char)
            i += 1
    return tokens

def find_last_vowel_index(tokens):
    for i in range(len(tokens) - 1, -1, -1):
        if tokens[i] in vowels:
            return i
    return -1

def process_tokens(tokens, heavy_end=False, use_x_below=False):
    processed_tokens = []
    last_vowel_index = find_last_vowel_index(tokens) if heavy_end else -1

    for i, token in enumerate(tokens):
        if token in long:
            if heavy_end and i == last_vowel_index:
                processed_tokens.append(token + ('\u0353' if use_x_below else '\u0331'))
            else:
                processed_tokens.append(token + '\u0331')
        elif token in short:
            if heavy_end and i == last_vowel_index:
                processed_tokens.append(token + ('\u0353' if use_x_below else '\u0331'))
            else:
                n1, n2 = find_next_tokens(tokens, i)
                if n1 == ' ' or n1 is None or (n1 in consonants and n2 in vowels) or (n1 == 'b' and n2 == 'r') or (n1 == 'b' and n2 == 'y') or (n1 == 'v' and n2 == 'y'):
                    processed_tokens.append(token + '\u032E')
                else:
                    processed_tokens.append(token + '\u0331')
        else:
            processed_tokens.append(token)
    return processed_tokens

def find_next_tokens(tokens, current_index):
    n1 = None
    n2 = None
    count = 0
    for i in range(current_index + 1, len(tokens)):
        token = tokens[i]
        if token in consonants or token in vowels or token == ' ':
            if count == 0:
                n1 = token
            elif count == 1:
                n2 = token
                break
            count += 1
    return n1, n2
