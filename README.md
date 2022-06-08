# Py Tricks

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

- `-e` means editable at the corresponding folder location, not in `venv`
- `pip install -e .` for the files/modules in `src` to be accessed as a package. This is accompanied with `setup.py` and `setup.cfg` files
- `pip install -e ./upskills_submodules/tbocr` for the `tbocr` package

#### Git Submodule Config

The following commands shall be ran for importing the `tbocr` repository into the project files

- `git submodule init`
- `git submodule update`
- `git submodule add some_module`
