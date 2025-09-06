const fs = require('fs');
const readline = require('readline');

let digraphs = ["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"];
digraphs = digraphs.concat(digraphs.map(d => d.toUpperCase()));

let vowels = ["a", "i", "u", "e", "ā", "ī", "ū", "o"];
vowels = vowels.concat(vowels.map(v => v.toUpperCase()));

let long = ["e", "ā", "ī", "ū", "o"];
long = long.concat(long.map(l => l.toUpperCase()));

let short = ["a", "i", "u"];
short = short.concat(short.map(s => s.toUpperCase()));

let consonants = [
  "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
  "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s", "ṁ", "ṃ"
];
consonants = consonants
  .concat(consonants.map(c => c.toUpperCase()))
  .concat(["Kh", "Ch", "Ṭh", "Th", "Ph", "Gh", "Jh", "Ḍh", "Dh", "Bh"]);
  
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter the file name to process: ', (inputFileName) => {
  rl.question('Enter the output file name: ', (outputFileName) => {
    rl.question('Do you want to use end heavy? (y/n): ', (heavyEndOption) => {
      const heavyEnd = heavyEndOption.toLowerCase() === 'y' || heavyEndOption.toLowerCase() === 'yes';
      
      if (heavyEnd) {
        rl.question('Do you want to mark them with x below? (y/n): ', (xBelowOption) => {
          const useXBelow = xBelowOption.toLowerCase() === 'y' || xBelowOption.toLowerCase() === 'yes';
          processFile(inputFileName, outputFileName, heavyEnd, useXBelow);
        });
      } else {
        processFile(inputFileName, outputFileName, heavyEnd, false);
      }
    });
  });
});

function processFile(inputFileName, outputFileName, heavyEnd, useXBelow) {
  fs.readFile(inputFileName, 'utf8', (err, data) => {
    if (err) {
      console.error('Error reading the file:', err);
      rl.close();
      return;
    }

    const lines = data.split('\n');
    const processedLines = lines.map(line => {
      const tokens = tokenize(line);
      const processedTokens = processTokens(tokens, heavyEnd, useXBelow);
      return processedTokens.join('');
    });

    fs.writeFile(outputFileName, processedLines.join('\n'), (err) => {
      if (err) {
        console.error('Error writing the file:', err);
      } else {
        console.log(`Successfully processed ${inputFileName} and saved the output to ${outputFileName}`);
      }
      rl.close();
    });
  });
}

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
  return -1; // No vowel found
}

function processTokens(tokens, heavyEnd = false, useXBelow = false) {
  let processedTokens = [];
  const lastVowelIndex = heavyEnd ? findLastVowelIndex(tokens) : -1;
  
  for (let i = 0; i < tokens.length; i++) {
    const token = tokens[i];
    if (long.includes(token)) {
      // If heavy end is enabled and this is the last vowel
      if (heavyEnd && i === lastVowelIndex) {
        if (useXBelow) {
          processedTokens.push(token + '\u0353'); // Combining x below
        } else {
          processedTokens.push(token + '\u0331'); // Macron below (heavy)
        }
      } else {
        processedTokens.push(token + '\u0331'); // Macron below
      }
    } else if (short.includes(token)) {
      // If heavy end is enabled and this is the last vowel
      if (heavyEnd && i === lastVowelIndex) {
        if (useXBelow) {
          processedTokens.push(token + '\u0353'); // Combining x below
        } else {
          processedTokens.push(token + '\u0331'); // Macron below (heavy)
        }
      } else {
        const [n1, n2] = findNextTokens(tokens, i);
        if (n1 === ' ' || n1 === null || (consonants.includes(n1) && vowels.includes(n2)) || (n1 === 'b' && n2 === 'r') || (n1 === 'b' && n2 === 'y') || (n1 === 'v' && n2 === 'y')) {
          processedTokens.push(token + '\u032E'); // Breve below
        } else {
          processedTokens.push(token + '\u0331'); // Macron below
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