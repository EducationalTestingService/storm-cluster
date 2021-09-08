
# This is a generic Storm cluster container for RFS-based engines

## Scripts

- build.sh         -- build docker image
- registry_push.sh -- push the docker image to ECS
- start.sh         -- start the image in local docker for debugging and development

## Uploading to docker.io

Uploading to Docker HUB takes place in Github Action that is triggered
when a new push takes place for `main` branch.
