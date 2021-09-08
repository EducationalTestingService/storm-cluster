
# Introduction

This repository contains code to build and push a docker image for a generic [Apache Storm](https://storm.apache.org) cluster. 

This generic Apache Storm cluster docker image contains OpenJDK 11 as well as the following Apache tools: ActiveMQ, Nimbus, Storm, Supervisor, Zookeeper. A container based on this image can be used to start up a cluster and run any Storm topology. 

# Github Action

With every push to the `main` branch, a Github action runs that builds the docker image using the included `Dockerfile` and uploads the built image to docker hub. 

# Manual Scripts

If the image needs to be built, uploaded, or debugged manually, the following script can be used to do so:

- `build.sh` :  build docker image
- `registry_push.sh` :  push the docker image to ECS
- `start.sh` : start the image in local docker for debugging and development

