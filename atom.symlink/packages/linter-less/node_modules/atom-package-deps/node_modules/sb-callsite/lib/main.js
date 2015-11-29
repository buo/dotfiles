'use strict';
'use babel';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.capture = capture;
const extractionRegex = /at (.*?) \((.*?):(\d+):(\d+)\)/;

function capture() {
  const toReturn = [];
  const stack = new Error().stack.split('\n');

  stack.shift();
  stack.forEach(function (entry) {
    const matches = extractionRegex.exec(entry);
    if (matches !== null) {
      toReturn.push({
        function: matches[1],
        file: matches[2],
        line: parseInt(matches[3]) || 1,
        col: parseInt(matches[4]) || 1
      });
    }
  });
  // Remove self from the stack
  toReturn.shift();

  return toReturn;
}