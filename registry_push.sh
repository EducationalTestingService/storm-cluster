#! /bin/bash

set -euo pipefail
if [[ ${USERNAME:-} ]]; then
    docker_login=${USERNAME}
else
    docker_login=${USER:?}
fi

image_name=storm-cluster
registry=docker.io/etslabs
tag=${tag:-latest}

if [[ $tag != 'latest' ]]; then
    if podman image exists "localhost/$image_name:$tag"; then
        : ok
    else
        podman tag "localhost/$image_name:latest" "localhost/$image_name:$tag"
    fi
fi

# Tag your podman image:
podman tag \
       "localhost/$image_name:$tag" \
       "$registry/$image_name:$tag"

echo "INFO: Using '$docker_login' to push new image to docker.io ..." >&2

# Push your podman image to the registry:
podman push "$registry/$image_name:$tag" "--creds=$docker_login"
