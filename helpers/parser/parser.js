const fs = require('fs');
const readline = require('readline');
const {
  tokenize,
  processTokens,
} = require('./parserUtils');

  
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