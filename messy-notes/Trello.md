## Trello
#### Backup

Pretty-printing JSON:
```
$ cat TrelloBackup-Raw-2015-12-04.json | jq . > TrelloBackup-2015-12-04.json
```
or
```
$ cat TrelloBackup-Raw-2015-12-04.json | python -m json.tool > alfa.json  ;; Escapes unicode characters, unfortunately
```