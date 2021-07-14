
# This is a generic Storm cluster container for RFS-based engines

## Scripts

- build.sh      -- build docker image
- ecr_create.sh -- create ECS repository for this image
- ecr_login.sh  -- authorize Docker daemon to work with ECS
- ecr_push.sh   -- push the docker image to ECS
- start.sh      -- start the image in local docker for debugging and development
