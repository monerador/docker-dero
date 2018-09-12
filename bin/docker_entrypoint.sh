#!/bin/bash

set -exuo pipefail

DERO_DIR=/dero

if [ $# -eq 0 ]; then
  exec /dero/dero_linux_amd64/derod-linux-amd64 --rpc-bind=0.0.0.0:30306 --data-dir=${DERO_DIR}
else
  exec "$@"
fi
