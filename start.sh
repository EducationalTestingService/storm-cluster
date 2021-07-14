#! /bin/sh

set -euo pipefail

IMAGE=nlparch-storm-cluster
NAME=nlparch-storm-cluster

if docker ps -a | sed 's/  */ /g' | cut -d ' ' -f 2 | egrep "^$IMAGE\$"
then
    echo container $IMAGE exists >&2
    exit 1
fi

docker run \
       -m 6g -d --name $NAME \
       $IMAGE bash -c "tail -f /dev/null"
