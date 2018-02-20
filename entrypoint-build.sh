#!/usr/bin/env bash

set -e
set -o pipefail

cd "$(dirname "$0")"

pip install -U pip-tools
exec "$@"
