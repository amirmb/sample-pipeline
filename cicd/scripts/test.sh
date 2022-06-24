#!/usr/bin/env bash

set -e
set -x

# Install dependencies
pip3 install --upgrade --requirement requirements.txt

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd ${SCRIPT_DIR}/../..
PROJECT_ROOT=$(pwd)

PROJECT_SRC_ROOT="${PROJECT_ROOT}/src"
PROJECT_TST_ROOT="${PROJECT_ROOT}/test"

# Run Test
export PYTHONPATH=${PROJECT_TST_ROOT}:${PROJECT_SRC_ROOT}:${PYTHONPATH}

nosetests --with-xunit tests/unit
