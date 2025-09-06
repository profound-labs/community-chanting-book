const fs = require('fs');
const readline = require('readline');

const digraphs = ["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"];
const vowels = ["a", "i", "u", "e", "ā", "ī", "ū", "o"];
const long = ["e", "ā", "ī", "ū", "o"];
const short = ["a", "i", "u"];
const consonants = [
  "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
  "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s", "ṁ", "ṃ"
];

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter the file name to process: ', (inputFileName) => {
  rl.question('Enter the output file name: ', (outputFileName) => {
    fs.readFile(inputFileName, 'utf8', (err, data) => {
      if (err) {
        console.error('Error reading the file:', err);
        rl.close();
        return;
      }

      const lines = data.split('\n');
      const processedLines = lines.map(line => {
        const tokens = tokenize(line);
        const processedTokens = processTokens(tokens);
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
  });
});

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

function processTokens(tokens) {
  let processedTokens = [];
  for (let i = 0; i < tokens.length; i++) {
    const token = tokens[i];
    if (long.includes(token)) {
      processedTokens.push(token + '\u0331'); // Macron below
    } else if (short.includes(token)) {
      const [n1, n2] = findNextTokens(tokens, i);
      if (n1 === ' ' || n1 === null || (consonants.includes(n1) && vowels.includes(n2)) || (n1 === 'b' && n2 === 'r')) {
        processedTokens.push(token + '\u032E'); // Breve below
      } else {
        processedTokens.push(token + '\u0331'); // Macron below
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