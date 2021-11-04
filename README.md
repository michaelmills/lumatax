# Michael Mills - LumaTax

## Prerequisites
The following software is required:
 * Node.js and Npm
  * I recommend installing both using Homebrew: https://changelog.com/posts/install-node-js-with-homebrew-on-os-x

 * Angular (https://angular.io/guide/setup-local)

 * Java (recommend JDK 8 or greater)

 * Maven (https://maven.apache.org/install.html)

 * Docker (https://docs.docker.com/get-docker/)

 * Docker-compose (https://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/How_to_Install_Docker_Compose.html)


## Build and Run - Using script (w/ docker-compose)
1. Open a terminal

2. Navigate to top level folder of this project (Lumatax)

3. Run script './startup.sh'
  * This will build both the Spring Boot server and Angular frontend
    The Angular application may take a while to build. If it's stuck on ' 92% chunk asset optimization UglifyJSPlugin' don't be alarmed. It will finish.
  * After it's done building, docker-compose will start up both services and logs for both services will appear.

4. Open a browser and navigate to http://localhost
  * The angular application uses port 80, so make sure nothing else is using it.


## Access the in-memory H2 database
1. If the Spring boot server is running (lumatax-server), open a browser and navigate to http://localhost:8082/h2
2. Enter the jdbc url on the login page as jdbc:h2:mem:lumatax-db
3. Username is 'sa'
4. Password is empty


## Build without script
### Build Spring Boot server
1. Navigate to the lumatax-server in the project folder
2. Run: mvn clean install
    This will build and create the docker image

### Build Angular frontend
1. Navigate to the lumatax-portal in the project folder
2. Run: npm install
2. Run: npm run docker_build


## Run without script
1. Open a terminal
2. Run docker images
3. Make sure mrmills/lumatax-server and mrmills/lumatax-portal is present
4. Navigate to the top folder of the lumatax project
5. Run the server:
    docker run --publish 8082:80 --env-file ./lumatax-server/lumatax-server.env mrmills/lumatax-server:1.0.0
6. Open another terminal and navigate to the top folder of the lumatax project
7. Run the angular frontend:
    docker run --publish 80:80 --env-file ./lumatax-portal/lumatax-portal.env mrmills/lumatax-portal:1.0.0
8. Open http://localhost in browser
