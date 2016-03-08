# Promisify
A node module to help you convert callback-style functions to promises

## Installation

```js
npm install --save sb-promisify
```

## API

```js
export default function promisify(callback)
```

## Example Usage

```js
'use babel'

import promisify from 'sb-promisify'
import fs from 'fs'

const readFile = promisify(fs.readFile)

readFile('/etc/passwd').then(function(contents) {
  console.log(contents.toString('utf8'))
}, function() {
  console.error('Unable to read file')
})
```

## License
This module is licensed under the terms of MIT License. Check the LICENSE file for more info.
