#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

# parse PYTHON_VERSION from the -v argument
PYTHON_VERSION="3.10.8"
USE_NVIM=0
while getopts ":vn:" opt; do
  case $opt in
    v) PYTHON_VERSION="$OPTARG"
    ;;
    n) USE_NVIM=1
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
    # show help
    :) echo "Option -$OPTARG requires an argument." >&2
  esac
done

# if a virtual environment is not currently activated, create one
if [ -z "${VIRTUAL_ENV:-}" ]; then
  # specify python version
  pyenv local $PYTHON_VERSION
  # create virtual environment
  python -m venv venv
  # ignore it
  echo "venv" >> .gitignore
  # add to direnv
  echo -e "export VENV_CMD=\"source $(pwd)/venv/bin/activate\"" > .envrc
  direnv allow .
  # init venv
  source venv/bin/activate
  pip install --upgrade pip

  if [ $USE_NVIM -eq 1 ]; then
    pip install pynvim
  fi
fi


