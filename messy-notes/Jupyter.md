## Jupyter
#### Configuration

- [Official reference](http://jupyter-notebook.readthedocs.io/en/stable/notebook.html)

- Get help:
```
$ jupyter notebook --help-all
```
- Create a `jupyter_notebook_config.py` in the `.jupyter` directory:
```
$ jupyter notebook --generate-config
```
- Set local directory in `jupyter_notebook_config.py`:
```
c.NotebookApp.notebook_dir = '/home/user/workspace/jupyter/notebooks'
```
- Enable ipywidgets (`python-ipywidgets` package):
```
$ sudo jupyter nbextension enable --py --sys-prefix widgetsnbextension
```

#### Usage

- Start server:
```
$ jupyter notebook
```
- Specify workspace and start server:
```
$ jupyter notebook --notebook-dir=/home/user/workspace/project
```
- Check server and get token:
```
$ jupyter notebook list
```

#### Jupyter Widgets

- [Docs](http://ipywidgets.readthedocs.io/en/latest/index.html)

- [HBox example](https://stackoverflow.com/questions/45464424/how-to-change-the-default-position-of-a-ipywidget-slider-to-the-side-of-a-matplo)

#### Matplotlib

- [Interactive matplotlib plot with two sliders](https://stackoverflow.com/questions/6697259/interactive-matplotlib-plot-with-two-sliders)

- [Vertical slider](https://stackoverflow.com/questions/25934279/add-a-vertical-slider-with-matplotlib)

- [Matplotlib, subplots](https://stackoverflow.com/questions/3584805/in-matplotlib-what-does-the-argument-mean-in-fig-add-subplot111)

#### Miscellany

- [Git integration](https://github.com/jupyter/nbdime)

- [Interactive visualization](https://towardsdatascience.com/interactive-visualizations-in-jupyter-notebook-3be02ab2b8cd), [GitHub](https://github.com/5agado)

- [plotly](https://plot.ly/python/widget-app/) Interactive Data Analysis with ipywidgets in Python

#### Jupyterlab

- [Cheat Sheet](https://blog.ja-ke.tech/2019/01/20/jupyterlab-shortcuts.html)
- [ArchWiki](https://wiki.archlinux.org/title/Jupyter)
```
$ jupyter lab paths
```
```
$ export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab
$ jupyter lab build
```
- Start:
```
$ jupyter lab
```
