#!/bin/bash

repo="wellharbor.westwell-research.com/k8s/kubectl-proxy"
tag="latest"

docker build -t $repo:$tag .
docker push $repo:$tag