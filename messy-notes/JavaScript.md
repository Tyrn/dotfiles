## Javascript bits and pieces
### CoffeScript

Project directory:
```
$ git init
$ npm init
```
Compilation on file save:

`$ coffee -wc *.coffee`

Unit test configuration (suboptimal, without nodemon):

`procr` - source directory
`dist` - output directory

`package.json`:
```
...
"scripts": {
  "test": "mocha -w --compilers coffee:coffee-script/register",
  "start": "(coffee --compile --output dist --watch procr &);node ./dist/pcn.js"
}
...
```
