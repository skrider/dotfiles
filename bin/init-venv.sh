#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

PYTHON_VERSION="${PYTHON_VERSION:-3.10.8}"
NUMERIC=0
JUPYTER=0
LSP=0

# parse options p, numeric, and jupyter
while getopts ":p:njsh" opt; do
  case $opt in
    p) PYTHON_VERSION="$OPTARG"
    ;;
    n) NUMERIC=1
    ;;
    s) LSP=1
    ;;
    j) JUPYTER=1
    ;;
    h) echo "Usage: init-venv.sh [-p python_version] [-n] [-j] [-s] [-h]"
       echo "  -p python_version: specify python version, default is 3.10.8"
       echo "  -n: install numpy, scipy, matplotlib"
       echo "  -j: install jupyter"
       echo "  -s: install python-language-server"
       echo "  -h: print this help message"
       exit 0
    ;;
  esac
done

# source virtual environment if one exists
if [ -f venv/bin/activate ]; then
  source venv/bin/activate
fi
# else create virtual environment and source
if [ ! -d venv ]; then
  pyenv local $PYTHON_VERSION
  python -m venv venv
  source venv/bin/activate
  pip install --upgrade pip
  pip install pynvim
fi

# conditionally install jupyter dependencies
if [ "$JUPYTER" == 1 ]; then
  pip install jupyter ipykernel jupyter-ascending
  jupyter nbextension    install jupyter_ascending --sys-prefix --py
  jupyter nbextension     enable jupyter_ascending --sys-prefix --py
  jupyter serverextension enable jupyter_ascending --sys-prefix --py
fi

# conditionally install numeric dependencies
if [ "$NUMERIC" == 1 ]; then
  pip install numpy scipy matplotlib
fi

# install LSP dependencies
if [ "$LSP" == 1 ]; then
  pip install 'python-language-server[all]'
fi

