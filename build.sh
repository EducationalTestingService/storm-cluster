#! /bin/bash

set -euo pipefail
image_name=storm-cluster

podman build --no-cache -t $image_name .
