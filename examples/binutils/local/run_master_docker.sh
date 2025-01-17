#!/bin/bash

# sudo docker build -t hopper-node .
## Create Hopper subnet
docker network create hopper-subnet &> /dev/null
mkdir hopper_out
export HOPPER_OUT="/hopper_out"
## Spawn Master
docker run -it --rm \
    --name hopper-master \
    --env TERM \
    --env HOPPER_OUT \
    --volume $(pwd)$HOPPER_OUT:$HOPPER_OUT \
    --network hopper-subnet \
    --publish 6969:6969 \
    hopper-readelf:latest \
    bash -c "cd hopper; go build .; ./hopper -I ./examples/binutils/readelf/in -H=20"
## Clean up subnet
docker network rm hopper-subnet &> /dev/null

