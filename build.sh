#! /bin/bash

set -euo pipefail
image_name=storm-cluster
if command -v podman > /dev/null; then
    docker=podman
else
    docker=docker
fi

$docker build --no-cache -t $image_name .
