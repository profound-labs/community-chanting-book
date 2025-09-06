Community Chanting Book

English, Vol 1: 978-1-78432-031-7
English, Vol 2: 978-1-78432-032-4
English, Retreat Centre: 978-1-78432-041-6

English, Vol 1 A4 Edition: 978-1-78432-173-4

Github: https://github.com/profound-labs/community-chanting-book

## Parser for rythmic marks

Run `node parser.js` to parse the rythmic marks a text file.

Run `mode parserGlobal.js` to parse entire folder recusivly by detecting pali line using diacritics, typiccaly in `/chapters/english`. Carefull as some line are not parsed if the don't contain any of the diacritics. Also some random line will be proccessed.

The original `parser.js` was created via gemini-cli (in termux on my ereader...) using the following prompt:

    I want to transform the lines of pali chanting in an external file by adding rhythmic symbols below the vowels. The line should remain intact in terms of case and punctuation, appart from adding rhythmic mark. Produce a node script that will:
    1. define:
    const digraphs = ["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"];
    const vowels = ["a", "i", "u", "e", "ā", "ī", "ū", "o"];
    const long = ["e", "ā", "ī", "ū", "o"];
    const short = ["a", "i", "u"];
    const consonants = [
        "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
        "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s","ṁ", "ṃ"
    ];
    
    2. Parse each line of the content
    3. Create an array representing the tokens of the line following the rules:
        1. Phonemes should be combined, i.e. d + h = dh, etc. to form one token
            1. For each char of the category digraphs, if it is followed by h -> combine them with h and remove taht h from the rest of the line
        2. For the other characters, each characters represent one token, letter as well as punctuation.
    4. For each token t, check
        1. t = long vowel -> add a macron under the vowel
        2. t = short vowel -> find the next two tokens (n1 and n2) that are either vowels, consonants or spaces
                1. If n1 = space or end of line -> add a breve under the vowel
                2. If n1 = consonant and n2 = vowel -> add a breve under the vowel
                3. If n1 = b and n2 = r -> add a breve under the vowel
                4. Else -> add a macron under the vowel
    5. Output all the tokens joined together
    6. Repeat for each line.

`parserGlobal.js` was created using claude web.

Note: End heavy option was added later to the parser. The original parsers are kept with the `noEndheavyOption` tag for the moment. 

Note: A similar result could be achived in python, but I started the project in JS so I continued. 