#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

# if not in a venv, exit
if [ -z "${VIRTUAL_ENV:-}" ]; then
    echo "Not in a virtualenv, exiting"
    exit 1
fi

NUMERIC=0
JUPYTER=0
LSP=0

# parse options p, numeric, and jupyter
while getopts ":p:njsh" opt; do
  case $opt in
    n) NUMERIC=1
    ;;
    s) LSP=1
    ;;
    j) JUPYTER=1
    ;;
    h) echo "Usage: init-venv.sh [-n] [-j] [-s] [-h]"
       echo "  -n: install numpy, scipy, matplotlib"
       echo "  -j: install jupyter"
       echo "  -s: install python-language-server"
       echo "  -h: print this help message"
       exit 0
    ;;
  esac
done

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

