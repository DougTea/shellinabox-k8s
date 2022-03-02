#!/bin/bash

repo="wellharbor.westwell-research.com/well_spiking/shellinabox"

docker build -t $repo:ubuntu .
docker push $repo:ubuntu