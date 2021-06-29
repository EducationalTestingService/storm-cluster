#! /bin/bash

set -euo pipefail
image_name=nlparch-storm-cluster
aws_region=us-east-1

# Tag your docker image: 
docker tag \
       $image_name:latest \
       435708183536.dkr.ecr.us-east-1.amazonaws.com/$image_name:latest

# Push your docker image to the registry:
docker push 435708183536.dkr.ecr.us-east-1.amazonaws.com/$image_name:latest
