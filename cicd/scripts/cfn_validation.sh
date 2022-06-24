#!/usr/bin/env bash

set -e
set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd ${SCRIPT_DIR}/../..
PROJECT_ROOT=$(pwd)

function validate() {
    for template in $(ls *.yaml -1); do
        aws cloudformation validate-template --template-body file://${template}
    done
}

cd ${PROJECT_ROOT}/iac && validate
