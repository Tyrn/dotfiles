## Heroku
- Get acquainted with the [Python Poetry Buildpack](https://elements.heroku.com/buildpacks/moneymeets/python-poetry-buildpack);
  [discussion](https://stackoverflow.com/questions/51815542/heroku-missing-required-flag-a)
- Install Heroku CLI utility:
```
$ yay -S heroku-cli
```
- Create an application on your [dashboard](https://dashboard.heroku.com/apps), check:
```
$ heroku apps
```
- Configure your Heroku environment:
```
$ heroku buildpacks:clear
$ heroku buildpacks:add https://github.com/moneymeets/python-poetry-buildpack.git
$ heroku buildpacks:add heroku/python
heroku config:set POETRY_VERSION=1.1.10
```
- Check:
```
$ heroku config
```
- Upload your application:
```
$ heroku git:remote -a your-app
$ git push heroku master
$ heroku run -a your-app
```
