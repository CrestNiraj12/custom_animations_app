import { danger, fail, warn } from "danger"
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
    child_process.execSync('flutter analyze', { encoding: 'utf-8' });
  } catch (error) {
    fail(`Flutter analyzer failed. Please fix the issues reported by the analyzer. ${error}`)
  }
}

checkIsBodyEmpty()
checkPRSize()
runFlutterAnalyzer()
