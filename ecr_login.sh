#! /bin/bash

set -euo pipefail
image_name=nlparch-storm-cluster
aws_region=us-east-1
registry=435708183536.dkr.ecr.us-east-1.amazonaws.com
# registry=docker.io/etslabs

# Provide the registry login credentials to the podman daemon:
aws ecr get-login-password --region $aws_region \
    | podman login \
             --username AWS \
             --password-stdin \
             $registry
