!/bin/sh

# Functions
get_help(){
	echo "Bash Script to help install python dependencies for the TBParse project";
	echo "please remember to activate your virtual environment before running this script";
	echo "Flags:";
	echo "-d	dev flag, install dev dependencies as well";
	echo "-g	gpu flag, installs gpu libraries for ML modules";
	echo "-h	help flag, print this help message";
}

# defaults
dev=0
gpu=0

# shell options
while getopts dgh flag; do
	case $flag in
		d) dev=1;;
		g) dev=1; gpu=1;;
		h) get_help; exit 0;;
	esac
done

echo "using `which pip`"
echo "are you sure you sourced your venv correctly?"
read -p "[press ENTER to continue, Ctrl-c to exit] " output

echo "[UPGRADING PIP]"
pip install --upgrade pip || exit 1;

echo "[INSTALLING REQUIREMENTS]"
pip install -r requirements.txt || exit 1;

if [ $gpu -eq 1 ]; then
      echo "[REMOVING TORCH CPU AND TORCHVISION CPU]"
      echo "If you want to use Pytorch with gpu,"
      echo "uninstall torch and torchvision before" 
      echo "installing torch gpu versiosn in requirements-dev]"
       pip uninstall -y torch torchvision || exit 1; 
fi 
if [ $dev -eq 1 ]; then
	echo "[INSTALLING DEV REQUIREMENTS]";
	pip install -r requirements-dev.txt || exit 1;
fi

echo "[INSTALLING PRECOMMIT HOOKS]"
pre-commit install 

echo "[INSTALLING SUBMODULE TBOCR]"
# since this project contain submodules from other repos
# git submodule update --init: is to pull those submodules
git submodule update --init || exit 1;
pip install -e upskills_submodules/tbocr || exit 1;
{ 
	cd upskills_submodules/tbocr;
	pre-commit install ;
}

echo "[INSTALLING Tbparse via setup.py]"
pip install -e . || exit 1;

echo "[INSTALL COMPLETE]"
