Python Virtual Environment Tips & Tricks
=

Create folder
-
    mkdir ~/Repos/stash/toolbox/new-feature
    cd !^ (or cd $_)

Set up
-

Install pipenv if not already installed

    python3 -m pip install --user pipenv

Install Python version

```bash
# get list of versions available
pyenv install --list
pyenv install 3.9.7
pyenv install 3.10
# View versions
pyenv versions
# Set Python version globally
pyenv global system 3.9.7
# Set Python version for local project only
pyenv local 3.10.8
# You can set the version of Python to be used in the current shell with pyenv shell
pyenv shell 3.10.8
# Check current version of Python
Python -V
```

### Remove existing pipenv??? ###
```bash
exit    # exit from your existing venv
pipenv --rm
```

### Option A: Install a base package (pypi is used as an example) ###
#### Create new virtual environment ####
```bash
pyenv install 3.9.7
mkdir .venv
pipenv --python 3.9.7
pipenv install <package>
```

### Activate workspace (`Pipfile` and `Pipfile.lock` are created) ###
    
```bash
pyenv shell 3.9.7
# Or
pipenv shell
```
### Run application ###
Several MAIA apps are designed to run like this:
```bash
pipenv run python app.py
```

## Activation Workflow ##
When activating an existing workspace, typically you'd want to run these commands:
```bash
pipenv install
pipenv shell
```
## Pip Freeze ##
Rather than  use `pip freeze` in your pipenv environment, you can use `pipenv` itself to create `requirements.txt`
```bash
# as of 01/2023 this is the proper way to do this
pipenv requirements > requirements.txt
```
## Errors ##
### When Installing ###
You may see an error similar to this:

    ERROR: Could not find a version that satisfies the requirement shlex (from versions: none)
    ERROR: No matching distribution found for shlex

This may happen if you already have met the requirement; e.g. the package is already installed (or the package is installed by default)

### When "Freezing" ###
When attempting to list your environment's requirements using `pipenv requirements > requirements.txt` you may see this error:

    FileNotFoundError: [Errno 2] No such file or directory: '/Users/pakey/Repos/gitlab/surface-monitor-test/Pipfile.lock'

In order to create `Pipfile.lock` file, you simply issue:

    pipenv install

Now, your `Pipfile.lock` file exists.

### When Activating ###
When attempting to activate your virtual environment, you may see the following error:
```bash
$ pipenv shell
Usage: pipenv shell [OPTIONS] [SHELL_ARGS]...

ERROR:: --system is intended to be used for pre-existing Pipfile installation, not installation of specific packages. Aborting.
```
You have to remove previous virtual environments.  Find yours by running:
```bash
$ pipenv --venv
/Users/pakey/.local/share/virtualenvs/poller-r0kLuxPh
```
Then, remove the entire folder:
```bash
$ rm -rf /Users/pakey/.local/share/virtualenvs/poller-r0kLuxPh
```
Try again:
```bash
$ pipenv shell
Creating a virtualenv for this project...
Pipfile: /Users/pakey/Repos/stash/poller/Pipfile
Using /usr/local/bin/python3 (3.10.5) to create virtualenv...
⠸ Creating virtual environment...created virtual environment CPython3.10.5.final.0-64 in 868ms
  creator CPython3Posix(dest=/Users/pakey/.local/share/virtualenvs/poller-r0kLuxPh, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/Users/pakey/Library/Application Support/virtualenv)
    added seed packages: pip==22.1.2, setuptools==63.1.0, wheel==0.37.1
  activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

✔ Successfully created virtual environment!
Virtualenv location: /Users/pakey/.local/share/virtualenvs/poller-r0kLuxPh
requirements.txt found in /Users/pakey/Repos/stash/poller instead of Pipfile! Converting...
✔ Success!
Warning: Your Pipfile now contains pinned versions, if your requirements.txt did.
We recommend updating your Pipfile to specify the "*" version, instead.
Launching subshell in virtual environment...
 . /Users/pakey/.local/share/virtualenvs/poller-r0kLuxPh/bin/activate
# this step happens automatically...
$  . /Users/pakey/.local/share/virtualenvs/poller-r0kLuxPh/bin/activate
```
Once your environment activates successfully, check your python version to ensure you get started off on the right foot:
```bash
python --version
```

#### Commit ####
When your happy, commit `Pipfile` to git as "Initial commit for pipenv"

### pipenv install ###
```bash
(maia-jes-executor) [pakey@LALAL0721100475 maia-models (python-3.9.7)]$ pipenv install
Pipfile.lock (78422d) out of date, updating to (652328)...
Locking [packages] dependencies...
Building requirements...
Resolving dependencies...
✘ Locking Failed!

Traceback (most recent call last):
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/resolver.py", line 816, in <module>
    main()
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/resolver.py", line 790, in main
    _ensure_modules()
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/resolver.py", line 16, in _ensure_modules
    spec.loader.exec_module(pipenv)
  File "<frozen importlib._bootstrap_external>", line 678, in exec_module
  File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_removed
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/__init__.py", line 58, in <module>
    from .cli import cli
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/cli/__init__.py", line 1, in <module>
    from .command import cli  # noqa
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/cli/command.py", line 7, in <module>
    from pipenv.cli.options import (
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/cli/options.py", line 3, in <module>
    from pipenv.project import Project
  File "/usr/local/Cellar/pipenv/2022.9.24/libexec/lib/python3.10/site-packages/pipenv/project.py", line 1
    from __future__ import annotations
    ^
SyntaxError: future feature annotations is not defined

(maia-jes-executor) [pakey@LALAL0721100475 maia-models (python-3.9.7)]$ python --version
Python 3.9.7
```
This is caused by an invalid `PATH`.  Follow along [here](https://github.com/pypa/pipenv/issues/4942#issuecomment-1156694881) but the gist is make sure you exit from a virtualenv before removing said virtualenv.  If a virtualenv is removed, make sure its path in no longer in your `PATH`.


## Update Python Version ##

```bash
# Install Python version of your choice
pipenv install 3.9.7
# Update the Python version in Pipfile
vi Pipfile
# Update your environment
pipenv update --python 3.9.7
```

## Other Errors ##

### Error: ###

    pipenv install --user paramiko
    Usage: pipenv install [OPTIONS] [PACKAGES]...
    ERROR:: --system is intended to be used for pre-existing Pipfile installation, not installation of specific packages. Aborting.

### Problem: ###

There is already a virtual environment present.

### Solution: ###

Check where virtual venv is

    pipenv --venv
    > /home/0816keisuke/.local/share/virtualenvs/dir_python-5Rka8dPB

Remove existing virtualenv

    cd ~/.local/share/virtualenvs
    rm -rf dir_python-5Rka8dPB

Remake virtualenv

    cd ~/dir_python
    pipenv --python 3

Install a package for dev only
-
    pipenv install -d <package_name>

Skip lock
-
    pipenv install --skip-lock

---
Examples:

    $ pipenv install pypi
    Creating a virtualenv for this project...
    Pipfile: /Users/pakey/Repos/stash/toolbox/surface-monitor-job-manager/Pipfile
    Using /usr/local/bin/python3 (3.10.2) to create virtualenv...
    ⠦ Creating virtual environment...created virtual environment CPython3.10.2.final.0-64 in 1126ms
      creator CPython3Posix(dest=/Users/pakey/.local/share/virtualenvs/surface-monitor-job-manager-63NZgpZw, clear=False, no_vcs_ignore=False, global=False)
      seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/Users/pakey/Library/Application Support/virtualenv)
        added seed packages: pip==22.0.4, setuptools==62.1.0, wheel==0.37.1
      activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

    ✔ Successfully created virtual environment!
    Virtualenv location: /Users/pakey/.local/share/virtualenvs/surface-monitor-job-manager-63NZgpZw
    Creating a Pipfile for this project...
    Installing pypi...
    Adding pypi to Pipfile's [packages]...
    ✔ Installation Succeeded
    Pipfile.lock not found, creating...
    Locking [dev-packages] dependencies...
    Locking [packages] dependencies...
    Building requirements...
    Resolving dependencies...
    ✔ Success!
    Updated Pipfile.lock (e48005)!
    Installing dependencies from Pipfile.lock (e48005)...
      🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 0/0 — 00:00:00
    To activate this project's virtualenv, run pipenv shell.
    Alternatively, run a command inside the virtualenv with pipenv run.

---

    pipenv install --dev

Set up virtual environment
=
Install your Python version

    pyenv install 3.9.15

Create the virtual environment

    virtualenv -p $(which python3) my_env

Activate it
    
    . ./my_env/bin/activate

Check python version to make sure it's 3.9.15, etc.

    python -V
