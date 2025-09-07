const fs = require('fs');
const path = require('path');
const readline = require('readline');
const {
  tokenize,
  processTokens,
} = require('./parserUtils');
const skipFiles = require('./skipFiles.json');
const paliWords = require('./paliWords.json');


// Pali-specific characters for detection
let paliIndicators = ["ṭ", "ḍ", "ṅ", "ñ", "ṇ", "ṁ", "ṃ", "ā", "ī", "ū", "ś", "ṣ"];
paliIndicators = paliIndicators.concat(paliIndicators.map(c => c.toUpperCase()));

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter the directory path to process recursively: ', (dirPath) => {
  rl.question('Create backup files? (y/n): ', (createBackup) => {
    rl.question('Do you want to use end heavy? (y/n): ', (heavyEndOption) => {
      const shouldBackup = createBackup.toLowerCase() === 'y';
      const heavyEnd = heavyEndOption.toLowerCase() === 'y' || heavyEndOption.toLowerCase() === 'yes';
      
      if (heavyEnd) {
        rl.question('Do you want to mark them with x below? (y/n): ', (xBelowOption) => {
          const useXBelow = xBelowOption.toLowerCase() === 'y' || xBelowOption.toLowerCase() === 'yes';
          startProcessing(dirPath, shouldBackup, heavyEnd, useXBelow);
        });
      } else {
        startProcessing(dirPath, shouldBackup, heavyEnd, false);
      }
    });
  });
});

function startProcessing(dirPath, shouldBackup, heavyEnd, useXBelow) {
  processDirectory(dirPath, shouldBackup, heavyEnd, useXBelow)
    .then(() => {
      console.log('Processing completed successfully!');
      rl.close();
    })
    .catch((err) => {
      console.error('Error during processing:', err);
      rl.close();
    });
}

async function processDirectory(dirPath, createBackup = false, heavyEnd = false, useXBelow = false) {
  try {
    const files = await getAllFiles(dirPath);
    let processedCount = 0;
    let skippedCount = 0;

    for (const file of files) {
      try {
        const processed = await processFile(file, createBackup, heavyEnd, useXBelow);
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
      const relativePath = path.relative(dirPath, fullPath);

      // Skip folders in skipFiles
      if (entry.isDirectory() && (
        skipFiles.includes(entry.name) ||
        skipFiles.includes(relativePath)
      )) {
        continue;
      }

      if (entry.isDirectory()) {
        await walkDirectory(fullPath);
      } else if (
        entry.isFile() &&
        isTextFile(entry.name) &&
        !skipFiles.includes(entry.name) &&
        !skipFiles.includes(relativePath)
      ) {
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

async function processFile(filePath, createBackup, heavyEnd, useXBelow) {
  const data = await fs.promises.readFile(filePath, 'utf8');
  const lines = data.split('\n');
  let hasChanges = false;
  let hasPaliContent = false;

  const processedLines = lines.map(line => {
    // Skip lines that start with "\" or "{" (LaTeX commands)
    if (line.trim().startsWith('\\') || line.trim().startsWith('{')) {
      return line;
    }
    
    if (containsPaliText(line)) {
      hasPaliContent = true;
      const originalLine = line;
      const tokens = tokenize(line);
      const processedTokens = processTokens(tokens, heavyEnd, useXBelow);
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
  // Check for Pali-specific diacritical marks
  for (const indicator of paliIndicators) {
    if (line.includes(indicator)) {
      return true;
    }
  }
  // Check for Pali words (case-insensitive)
  const lowerLine = line.toLowerCase();
  for (const word of paliWords) {
    if (lowerLine.includes(word.toLowerCase())) {
      return true;
    }
  }
  return false;
}
