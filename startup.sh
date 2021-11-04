#!/bin/sh

# check that git submodules are populated
if [ -z "$(ls -A ./lumatax-portal)" ]; then
  git submodule init
  git submodule update
fi

sleep 8

# build server
cd lumatax-server
mvn clean install

# build frontend
cd ../lumatax-portal
npm install
npm run docker_build

# start both services using docker-compose
cd ../docker
docker-compose up
