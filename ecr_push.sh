#! /bin/bash

set -euo pipefail
image_name=nlparch-storm-cluster
aws_region=us-east-1

# Tag your podman image:
podman tag \
       $image_name:latest \
       435708183536.dkr.ecr.us-east-1.amazonaws.com/$image_name:latest

# Push your podman image to the registry:
podman push 435708183536.dkr.ecr.us-east-1.amazonaws.com/$image_name:latest
