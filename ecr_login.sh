#! /bin/bash

set -euo pipefail
image_name=nlparch-storm-cluster
aws_region=us-east-1

# Provide the registry login credentials to the docker daemon:
aws ecr get-login-password --region $aws_region \
    | docker login \
             --username AWS \
             --password-stdin \
             435708183536.dkr.ecr.us-east-1.amazonaws.com
