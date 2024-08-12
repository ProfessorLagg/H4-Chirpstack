#!/bin/sh

oldpath=$(realpath .)
cd ~
rm -rf chirpstack-docker
git clone https://github.com/brocaar/chirpstack-docker.git
cd chirpstack-docker
sudo docker-compose up
cd $oldpath