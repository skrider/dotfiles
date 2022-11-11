#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

PYTHON_VERSION="${PYTHON_VERSION:-3.10.8}"
NUMERIC=0
JUPYTER=0
LSP=0

# parse options p, numeric, and jupyter
while getopts ":p:njs" opt; do
  case $opt in
    p) PYTHON_VERSION="$OPTARG"
    ;;
    n) NUMERIC=1
    ;;
    s) LSP=1
    ;;
    j) JUPYTER=1
    ;;
  esac
done

# create virtual environment

pyenv local $PYTHON_VERSION
python -m venv venv
source venv/bin/activate

# install dependencies
pip install pynvim

# conditionally install jupyter dependencies
if [ -n "$JUPYTER" ]; then
  pip install jupyter ipykernel jupyter-ascending
  jupyter nbextension    install jupyter_ascending --sys-prefix --py
  jupyter nbextension     enable jupyter_ascending --sys-prefix --py
  jupyter serverextension enable jupyter_ascending --sys-prefix --py
fi

# conditionally install numeric dependencies
if [ -n "$NUMERIC" ]; then
  pip install numpy scipy matplotlib
fi

# install LSP dependencies
if [ -n "$LSP" ]; then
  pip install 'python-language-server[all]'
fi

