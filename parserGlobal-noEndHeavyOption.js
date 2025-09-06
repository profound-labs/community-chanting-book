const fs = require('fs');
const path = require('path');
const readline = require('readline');

const digraphs = ["k", "c", "ṭ", "t", "p", "g", "j", "ḍ", "d", "b"];
const vowels = ["a", "i", "u", "e", "ā", "ī", "ū", "o"];
const long = ["e", "ā", "ī", "ū", "o"];
const short = ["a", "i", "u"];
const consonants = [
  "k", "c", "ṭ", "t", "p", "kh", "ch", "ṭh", "th", "ph", "gh", "jh", "ḍh", "dh", "bh",
  "g", "j", "ḍ", "d", "b", "ṅ", "ñ", "ṇ", "n", "m", "h", "y", "r", "l", "v", "ś", "ṣ", "s", "ṁ", "ṃ"
];

// Pali-specific characters for detection
const paliIndicators = ["ṭ", "ḍ", "ṅ", "ñ", "ṇ", "ṁ", "ṃ", "ā", "ī", "ū", "ś", "ṣ"];

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter the directory path to process recursively: ', (dirPath) => {
  rl.question('Create backup files? (y/n): ', (createBackup) => {
    const shouldBackup = createBackup.toLowerCase() === 'y';
    
    processDirectory(dirPath, shouldBackup)
      .then(() => {
        console.log('Processing completed successfully!');
        rl.close();
      })
      .catch((err) => {
        console.error('Error during processing:', err);
        rl.close();
      });
  });
});

async function processDirectory(dirPath, createBackup = false) {
  try {
    const files = await getAllFiles(dirPath);
    let processedCount = 0;
    let skippedCount = 0;

    for (const file of files) {
      try {
        const processed = await processFile(file, createBackup);
        if (processed) {
          processedCount++;
          console.log(`✓ Processed: ${file}`);
        } else {
          skippedCount++;
          console.log(`- Skipped (no Pali content): ${file}`);
        }
      } catch (err) {
        console.error(`✗ Error processing ${file}:`, err.message);
      }
    }

    console.log(`\nSummary: ${processedCount} files processed, ${skippedCount} files skipped`);
  } catch (err) {
    throw new Error(`Failed to process directory: ${err.message}`);
  }
}

async function getAllFiles(dirPath) {
  const files = [];
  
  async function walkDirectory(currentPath) {
    const entries = await fs.promises.readdir(currentPath, { withFileTypes: true });
    
    for (const entry of entries) {
      const fullPath = path.join(currentPath, entry.name);
      
      if (entry.isDirectory()) {
        await walkDirectory(fullPath);
      } else if (entry.isFile() && isTextFile(entry.name)) {
        files.push(fullPath);
      }
    }
  }
  
  await walkDirectory(dirPath);
  return files;
}

function isTextFile(filename) {
  const textExtensions = ['.txt', '.tex', '.md', '.html', '.xml', '.json', '.csv'];
  const ext = path.extname(filename).toLowerCase();
  return textExtensions.includes(ext) || !path.extname(filename); // Include files without extension
}

async function processFile(filePath, createBackup) {
  const data = await fs.promises.readFile(filePath, 'utf8');
  const lines = data.split('\n');
  let hasChanges = false;
  let hasPaliContent = false;

  const processedLines = lines.map(line => {
    if (containsPaliText(line)) {
      hasPaliContent = true;
      const originalLine = line;
      const tokens = tokenize(line);
      const processedTokens = processTokens(tokens);
      const processedLine = processedTokens.join('');
      
      if (originalLine !== processedLine) {
        hasChanges = true;
      }
      
      return processedLine;
    }
    return line; // Return original line if no Pali content
  });

  // Only write file if it contains Pali content and has changes
  if (hasPaliContent && hasChanges) {
    if (createBackup) {
      const backupPath = filePath + '.bak';
      await fs.promises.copyFile(filePath, backupPath);
    }
    
    await fs.promises.writeFile(filePath, processedLines.join('\n'), 'utf8');
    return true; // File was processed
  }
  
  return false; // File was skipped
}

function containsPaliText(line) {
  // Only check for Pali-specific diacritical marks
  for (const indicator of paliIndicators) {
    if (line.includes(indicator)) {
      return true;
    }
  }
  
  return false;
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