## Python
### Package management
#### Poetry
A wealth of installation options can be found
[here](https://pypi.org/project/poetry/). The gist:
*do not install Poetry systemwide or from the distribution repositories*.
The easy way:
```
$ pip install poetry --user
```
or
```
$ pip install pipx --user
$ pipx install poetry
```
- [nodeenv](https://pypi.org/project/nodeenv/), or Python and JS in the same virtual environment
```
$ poetry add nodeenv

    $ poetry shell
    (.venv) $ nodeenv -p
    (.venv) $ nodeenv -r node-requirements.txt --update .venv

```
- The environment may not be quite ready; exit it (Ctrl-d in case of
  poetry shell) once before regular use.

- Do not use ``poetry run uvicorn ...`` alongside ``nodeenv``.
  Start this way:
```
$ poetry shell
(.venv) $ uvicorn src.goodmarks.start:app --reload
```
- Initial install and freeze.
```
(.venv) $ nodeenv -p
(.venv) $ npm install -g cheerio
(.venv) $ freeze node-requirements.txt
```
### Miscellaneous Howto
- [pathlib](http://pbpython.com/pathlib-intro.html)
- [reduce (list of strings) -> string
](https://stackoverflow.com/questions/27436748/python-reduce-list-of-strings-string)
- In case of a conflict, [force import](https://stackoverflow.com/questions/70220763/import-a-shadowed-module-from-a-package)
