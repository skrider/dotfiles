#!/bin/bash

set -o errexit
set -o nounset
# set -o xtrace

# parse PYTHON_VERSION from the -v argument
PYTHON_VERSION="3.10.8"
while getopts ":v:" opt; do
  case $opt in
    v) PYTHON_VERSION="$OPTARG"
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
  # add to direnv
  echo -e "export VENV_CMD=\"source $(pwd)/venv/bin/activate\"" > .envrc
  direnv allow .
  # init venv
  source venv/bin/activate
  pip install --upgrade pip
  pip install pynvim
fi


