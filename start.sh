#! /bin/sh

set -euo pipefail

IMAGE=storm-cluster
NAME=storm-instance

# make sure that the container doesn't already exist
if podman container exists "$NAME"; then
    echo "Container '$NAME' already exists" >&2
    exit 1
fi

podman run \
       -d --name $NAME \
       $IMAGE bash -c "tail -f /dev/null"
