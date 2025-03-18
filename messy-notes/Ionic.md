## Ionic
### Testing

*As of 2018-06-20 it won't work due to* `webpack < 4.x`.

#### [Leif Wells case](https://leifwells.github.io/2017/08/27/testing-in-ionic-configure-existing-projects-for-testing/)

- Create project
```
$ ionic start starter-with-testing sidemenu --v3
```
- Test project
```
$ cd starter-with-testing
$ ionic serve
```
- Install required Node modules
```
$ npm install --save-dev angular2-template-loader html-loader jasmine jasmine-spec-reporter karma karma-chrome-launcher karma-jasmine karma-jasmine-html-reporter karma-sourcemap-loader karma-webpack karma-coverage-istanbul-reporter istanbul-instrumenter-loader null-loader protractor ts-loader ts-node @types/jasmine @types/node
```
- Copy `test-config` directory from `ionic-unit-testing-example`. File list:
```
karma-test-shim.js
karma-config.js
mocks-ionic.js
protractor.conf.js
webpack.test.js
```
- Copy `e2e` directory from `ionic-unit-testing-example`. File list:
```
app.e2e-spec.ts
app.po.ts
tsconfig.json
```