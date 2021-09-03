#! /bin/bash

set -euo pipefail
if [[ ${USERNAME:-} ]]; then
    docker_login=${USERNAME}
else
    docker_login=${USER:?}
fi

image_name=storm-cluster
registry=docker.io/etslabs

# Tag your podman image:
podman tag \
       $image_name:latest \
       $registry/$image_name:latest

echo "INFO: Using '$docker_login' to push new image to docker.io ..." >&2

# Push your podman image to the registry:
podman push $registry/$image_name:latest --creds=$docker_login
