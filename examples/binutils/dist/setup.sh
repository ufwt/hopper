#!/bin/bash

set -e

# Update and install git and curl
sudo apt-get update && sudo apt-get install -y git curl

cd ~
# Install docker
if ! command -v docker &> /dev/null
then
    echo "Installing Docker"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Cleanup docker 
yes | sudo docker image prune
yes | sudo docker container prune

# Clone and build Hopper
git clone https://github.com/Cybergenik/hopper.git
cd hopper/
sudo docker build -t hopper-node .
cd examples/binutils/
sudo docker build -t hopper-readelf .
cd ~
cp ~/hopper/examples/binutils/dist/master.sh .
cp ~/hopper/examples/binutils/dist/node.sh .
