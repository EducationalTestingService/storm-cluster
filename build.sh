#! /bin/sh

set -euo pipefail
image_name=nlparch-storm-cluster

secret=$(mktemp)
trap "/bin/rm -f '$secret'" EXIT
uuidgen > "$secret"

DOCKER_BUILDKIT=1 docker build --progress=plain \
               --secret "id=password,src=$secret" \
               --no-cache \
               -t $image_name \
               .
