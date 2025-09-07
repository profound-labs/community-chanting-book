const digraphs = ["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"]
  .concat(["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"].map(d => d.toUpperCase()));

const vowels = ["a", "i", "u", "e", "ā", "ī", "ū", "o"]
  .concat(["a", "i", "u", "e", "ā", "ī", "ū", "o"].map(v => v.toUpperCase()));

const long = ["e", "ā", "ī", "ū", "o"]
  .concat(["e", "ā", "ī", "ū", "o"].map(l => l.toUpperCase()));

const short = ["a", "i", "u"]
  .concat(["a", "i", "u"].map(s => s.toUpperCase()));

const consonants = [
  "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
  "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s", "ṁ", "ṃ"
]
  .concat([
    "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
    "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s", "ṁ", "ṃ"
  ].map(c => c.toUpperCase()))
  .concat(["Kh", "Ch", "Ṭh", "Th", "Ph", "Gh", "Jh", "Ḍh", "Dh", "Bh"]);

function tokenize(line) {
  let tokens = [];
  let i = 0;
  while (i < line.length) {
    let char = line[i];
    if (digraphs.includes(char) && i + 1 < line.length && line[i + 1] === 'h') {
      tokens.push(char + 'h');
      i += 2;
    } else {
      tokens.push(char);
      i++;
    }
  }
  return tokens;
}

function findLastVowelIndex(tokens) {
  for (let i = tokens.length - 1; i >= 0; i--) {
    if (vowels.includes(tokens[i])) {
      return i;
    }
  }
  return -1;
}

function processTokens(tokens, heavyEnd = false, useXBelow = false) {
  let processedTokens = [];
  const lastVowelIndex = heavyEnd ? findLastVowelIndex(tokens) : -1;
  
  for (let i = 0; i < tokens.length; i++) {
    const token = tokens[i];
    if (long.includes(token)) {
      if (heavyEnd && i === lastVowelIndex) {
        if (useXBelow) {
          processedTokens.push(token + '\u0353');
        } else {
          processedTokens.push(token + '\u0331');
        }
      } else {
        processedTokens.push(token + '\u0331');
      }
    } else if (short.includes(token)) {
      if (heavyEnd && i === lastVowelIndex) {
        if (useXBelow) {
          processedTokens.push(token + '\u0353');
        } else {
          processedTokens.push(token + '\u0331');
        }
      } else {
        const [n1, n2] = findNextTokens(tokens, i);
        if (n1 === ' ' || n1 === null || (consonants.includes(n1) && vowels.includes(n2)) || (n1 === 'b' && n2 === 'r') || (n1 === 'b' && n2 === 'y') || (n1 === 'v' && n2 === 'y')) {
          processedTokens.push(token + '\u032E');
        } else {
          processedTokens.push(token + '\u0331');
        }
      }
    } else {
      processedTokens.push(token);
    }
  }
  return processedTokens;
}

function findNextTokens(tokens, currentIndex) {
  let n1 = null;
  let n2 = null;
  let count = 0;
  for (let i = currentIndex + 1; i < tokens.length; i++) {
    const token = tokens[i];
    if (consonants.includes(token) || vowels.includes(token) || token === ' ') {
      if (count === 0) {
        n1 = token;
      } else if (count === 1) {
        n2 = token;
        break;
      }
      count++;
    }
  }
  return [n1, n2];
}

module.exports = {
  tokenize,
  processTokens,
};