#!/usr/bin/env bash

set -e
set -x

# Install dependencies
pip3 install --requirement requirements.txt

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd ${SCRIPT_DIR}/../..
PROJECT_ROOT=$(pwd)

PROJECT_SRC_ROOT="${PROJECT_ROOT}/src"
PROJECT_TST_ROOT="${PROJECT_ROOT}/test"

# Run Lint
export PYTHONPATH=${PROJECT_TST_ROOT}:${PROJECT_SRC_ROOT}:${PYTHONPATH}

echo "Lint source code:"
pylint --rcfile=${PROJECT_ROOT}/.pylintrc ${PROJECT_SRC_ROOT} --disable=duplicate-code
pycodestyle ${PROJECT_SRC_ROOT} --max-line-length=200

echo "Lint test code:"
pylint --rcfile=${PROJECT_ROOT}/.pylintrc-tests ${PROJECT_TST_ROOT} --disable=duplicate-code
