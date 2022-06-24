#!/usr/bin/env bash

set -e
set -x

# Install dependencies
pip3 install --requirement requirements.txt

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd ${SCRIPT_DIR}/../..
PROJECT_ROOT=$(pwd)

PROJECT_SRC_ROOT="${PROJECT_ROOT}/src"

echo "Execute bandit on common code"
bandit -r "${PROJECT_SRC_ROOT}" -n 3 -lll

echo "Star Trufflehog"
trufflehog --regex --entropy=True --max_depth 20 --json "file://${PROJECT_ROOT}" || true
