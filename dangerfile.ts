import { danger, fail, message, warn } from "danger"
const child_process = require('child_process')

function checkIsBodyEmpty() {
  if (danger.github.pr.body == "") {
    warn("Please add a description to your PR.")
  }
}

function checkPRSize() {
  const maxLinesOfCode = 1000
  const linesOfCode = danger.github.pr.additions + danger.github.pr.deletions
  if (linesOfCode > maxLinesOfCode) {
    fail(`This pull request adds too many lines of code. It adds ${linesOfCode} lines, but the maximum allowed is ${maxLinesOfCode} lines.`)
  }
}

function runFlutterAnalyzer() {
  try {
    const analyzeOutput = child_process.execSync('flutter analyze', { encoding: 'utf-8' });
    const lines = analyzeOutput.split('\n');
    const issueRegex = /^(info|warning|error) • (.+) • (.+) • (.+)$/;

    lines.forEach((line) => {
      const match = line.match(issueRegex);
      if (match) {
        const [_, level, msg, file, location] = match;
        switch (level) {
          case 'error':
            fail(`${msg} (${file}:${location})`);
            break;
          case 'warning':
            warn(`${msg} (${file}:${location})`);
            break;
          case 'info':
            message(`${msg} (${file}:${location})`);
            break;
        }
      }
    });
  } catch (error) {
    fail(`Flutter analyzer failed. Please fix the issues reported by the analyzer. ${error}`)
  }
}

checkIsBodyEmpty()
checkPRSize()
runFlutterAnalyzer()
