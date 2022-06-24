#!/usr/bin/env bash

set -e
set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd ${SCRIPT_DIR}/../..
PROJECT_ROOT=$(pwd)

PROJECT_SRC_ROOT="${PROJECT_ROOT}/src"

python ${PROJECT_SRC_ROOT}/main.py