# 

```bash
# Operating System Level Installations
## macOS
### Jupyter
brew install jupyterlab
### Virtual Environment
pipenv install -d jupyterlab
### Pip modules
pipenv install -d jupyterlab-drawio

# Install support for extensions
pipenv install -d jupyter_contrib_nbextensions
jupyter contrib nbextension install 

# Install extensions
## Draw.io
jupyter labextension install jupyterlab-drawio

# Run Locally
jupyter notebook
```
