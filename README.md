# Python Tricks

## Tutorial

- [Docs](./doc/README.md)

## Installation

From the source directory run the following commands

### Virtual Env Creation & Activation

- `python -m venv venv` for initialising the virtual environment
- `source venv/bin/activate` for activating the virtual environment


#### Version 1 - Dependency Installation

The following commands shall be ran **after activating the virtual environment**.
- `pip install --upgrade pip` for upgrading the pip
- `pip install -r requirements.txt` for the functional dependencies
- `pip install -r requirements-dev.txt` for the development dependencies. (should include `pre-commit` module)
- `pre-commit install` for installing the precommit hook

For the extra modules, which are not a standard pip modules (either from your own `src` or from any github repo)
- `-e` means installing a project in editable mode, thus any local modifications made to the code will take effect without reinstallation.
- `pip install -e .` for the files/modules in `src` to be accessed as a package. This is accompanied with `setup.py` and `setup.cfg` files
- `pip install -e ./upskills_submodules/tbocr` for the `tbocr` package

#### Version 2 - Dependency Installation with BASH script
The following bash script `venvscript.sh` MUST be ran **after activating the virtual environment**.
- Install GPU + dev: `sh ./venv_script.sh -g`
- Install no GPU + dev: `sh ./venv_script.sh -d`


### Git Submodule Setup & Config
This section is **ONLY applicable if you firstly want to add** a new submodule to the main repo. (i.e. there is no `.gitmodules` file in the repo, or the submodule we want to add is not recored in the `.gitmodules` file)

- `git submodule init` - only need to run if the submodule is never initialized in the repo
- Create a folder that contains all the submodules, say `upskills_submodules`
  - Change to that directory `cd upskills_submodules`

In order to add a Git submodule, use the “git submodule add” command and specify the URL of the Git remote repository to be included as a submodule.

- `git submodule add git@bitbucket.org:upskills/tbocr.git` we want to add `tbocr` as a submodule for this project

The `tbocr` has been added as a submodule and it is automatically update in the `.gitmodules` file as follows
```git
[submodule "upskills_submodules/tbocr"]
	path = upskills_submodules/tbocr
	url = git@bitbucket.org:upskills/tbocr.git
```
- `git commit -m "Added the submodule to the project."` when adding a Git submodule, your submodule will be staged
- `git push` to the remote repository so that other developer can use.
##### For other developer to install submodules

- You can first start by cloning the repository, however, it is not cloning the content of the Git submodule.
- `git submodule update --init` to update Git configuration and clone the content of the Git submodule to his/her pc
- Install necessary stuffs (please refer to [Dependency installation](#dependency-installation))

