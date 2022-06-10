# Python Tricks

## Tutorial

- [Docs](./doc/README.md)

## Installation

From the source directory run the following commands

#### Virtual Env Creation & Activation

- `python -m venv venv` for initialising the virtual environment
- `source venv/bin/activate` for activating the virtual environment
- `pip install --upgrade pip` for upgrading the pip

#### Dependency Installation

The following commands shall be ran **after activating the virtual environment**.

- `pip install -r requirements.txt` for the functional dependencies
- `pip install -r requirements-dev.txt` for the development dependencies. (should include `pre-commit` module)
- `pre-commit install` for installing the precommit hook

For the extra modules, which are not a standard pip modules (either from your own `src` or from any github repo)
- `-e` means installing a project in editable mode, thus any local modifications made to the code will take effect without reinstallation.
- `pip install -e .` for the files/modules in `src` to be accessed as a package. This is accompanied with `setup.py` and `setup.cfg` files
- `pip install -e ./upskills_submodules/tbocr` for the `tbocr` package

#### Git Submodule Setup & Config
If you want to adding another existing Git repository as a submodule of your current repository that we’re working on. 
The following commands shall be ran for importing the `tbocr` repository into the project files

- `git submodule init`
- `git submodule update`
- `$cd folder_contains_submodules`
- `git submodule add some_module_name` for example: `git submodule add https://github.com/chaconinc/DbConnector`

You should notice the new .gitmodules file. This is a configuration file that stores the mapping between the project’s URL and the local subdirectory you’ve pulled it into:
```git
[submodule "to_folder_contains_submodules/DbConnector"]
	path = folder_contains_submodules/DbConnector
	url = https://github.com/chaconinc/DbConnector
```
