## NODEJS
### Maintenance

- Installing node-inspector:
```
$ sudo npm install --unsafe-perm -g node-inspector
```

- Debugging while port 8080 is busy:
```
$ node-debug -p 8082 try-debug.js 8081
Node Inspector is now available from http://127.0.0.1:8082/?ws=127.0.0.1:8082&port=5858
```
- Debugging `try-debug.js`

- 2015-12-10
```
$ npm ls -g --depth=0       ;; Works in ~ directory only.
```
