#! /bin/bash

set -euo pipefail

IMAGE=storm-cluster
NAME=storm-instance
if command -v podman > /dev/null; then
    docker=podman
else
    docker=docker
fi

# make sure that the container doesn't already exist
if (( $( $docker ps -a -f "name=$NAME" | wc -l ) == 2 )); then
    echo "Container '$NAME' already exists" >&2
    exit 1
fi

$docker run \
        -d --name $NAME \
        $IMAGE bash -c "tail -f /etc/hostname"

echo "To run shell: $docker container exec -it '$NAME' bash -il"
