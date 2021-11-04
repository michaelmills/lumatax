#!/bin/sh

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
