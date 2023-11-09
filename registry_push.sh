#! /bin/bash

set -euo pipefail
if [[ ${USERNAME:-} ]]; then
    docker_login=${USERNAME}
else
    docker_login=${USER:?}
fi
if command -v podman > /dev/null; then
    docker=podman
else
    docker=docker
fi

image_name=storm-cluster
registry=docker.io/etslabs
tag=${tag:-latest}

if [[ $tag != 'latest' ]]; then
    if (( $( $docker image ls "$image_name:$tag" | wc -l ) == 2 )); then
        : ok
    else
        $docker tag "$image_name:latest" "$image_name:$tag"
    fi
fi

# Tag your docker image:
$docker tag \
        "$image_name:$tag" \
        "$registry/$image_name:$tag"

echo "INFO: Using '$docker_login' to push new image to docker.io ..." >&2

# Push your docker image to the registry:
$docker login --username "$docker_login"
$docker push "$registry/$image_name:$tag"
