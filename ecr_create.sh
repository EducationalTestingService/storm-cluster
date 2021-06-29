#! /bin/bash

set -euo pipefail
image_name=nlparch-storm-cluster
aws_region=us-east-1

# Create a repository for your specific image in the container registry:
aws ecr create-repository \
    --repository-name $image_name \
    --image-scanning-configuration scanOnPush=true \
    --region $aws_region
