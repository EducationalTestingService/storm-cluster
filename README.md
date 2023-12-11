
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

# Pushing to ECR

This note is for ETS AI Labs NLP Architecture folks using this image. Whenever
you make changes to the image, you *must* manually push it to the ECR repo in
our nlplab-dev ETS AWS account.

To do so:

1. Install [Orbstack](https://orbstack.dev) on your Mac. Make sure it's
   installed and running.

2. Pull the latest `storm-cluster` docker image locally to your Mac by
   running `docker pull --platform linux/amd64 etslabs/storm-cluster`.

3. Authenticate to the ECR registry by running:

   ```
   aws-vault exec ets -- aws ecr get-login-password | docker login --username AWS --password-stdin 435708183536.dkr.ecr.us-east-1.amazonaws.com
   ```

   This assumes that you have /setup aws-vault correctly and the `ets` profile
   in `$HOME/.aws/config` is for the `nlplab-dev` account. The above command
   will print "Login Succeeded" if the authentication completes successfully.

4. Tag the storm-cluster image (using its Image ID) with the ECR information

   ```
   docker tag <image-id> 435708183536.dkr.ecr.us-east-1.amazonaws.com/storm-cluster:latest
   ```

5. Push the `storm-cluster` image to the registry

   ```
   docker push 435708183536.dkr.ecr.us-east-1.amazonaws.com/storm-cluster:latest
   ```

6. Check the repository under the ECR section in the AWS console and confirm
   that the latest image has been uploaded with the right date.

7. You must also ensure that the image does not have any vulnerabilities by
   checking the results of the AWS scan. These results might take a few hours
   to be ready.
