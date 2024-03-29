# Michael Mills - LumaTax

<img src="https://github.com/michaelmills/lumatax/blob/main/images/homepage.png" width="900">
<img src="https://github.com/michaelmills/lumatax/blob/main/images/summary.png" width="900">

## Challenge
You are creating a web application that allows a user to
1. upload and process sales transaction files submit a file
    1. parse the file
    1. validate each row
    1. mark each row as valid/invalid (see validation rules below)
    1. calculate sum of total sales, sum of total tax, and date range of all valid records in the file
    1. persist the rows and summary data in a datastore of your choice  
    
2. render transaction file summary
The field validation rules for the sales transactions are as follows:
* invoice_id: required, alphanumeric
* invoice_date: required, date
* total_sales: required, numeric
* total_tax: required, numeric
* state: required, char, must be a valid state 2-char abbreviation (e.g. CA)
* ship_to_zip: required, char, must be a 5-digit zipcode

---

## Prerequisites
The following software is required:
 * Node.js and Npm
   * I recommend installing both using Homebrew: https://changelog.com/posts/install-node-js-with-homebrew-on-os-x

 * Angular (https://angular.io/guide/setup-local)

 * Java (recommend JDK 8 or greater)

 * Maven (https://maven.apache.org/install.html)

 * Docker (https://docs.docker.com/get-docker/)

 * Docker-compose (https://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/How_to_Install_Docker_Compose.html)

---

## Build and Run - Using script (w/ docker-compose)  
*Preferred approach*  

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

---

## Build without script
*This is a backup approach*  

### Build Spring Boot server
1. Navigate to the lumatax-server in the project folder
2. Run: mvn clean install  
    This will build and create the docker image

### Build Angular frontend
1. Navigate to the lumatax-portal in the project folder
2. Run: npm install
2. Run: npm run docker_build

### * Two approaches to running the application below  

## Run with Docker-compose
1. Open a terminal
2. Run:  
    docker images
4. Make sure mrmills/lumatax-server and mrmills/lumatax-portal is present
5. Navigate to the docker folder in the top level of project
6. Run:  
    docker-compose up (or 'docker-compose up -d' for detached mode)
7. Open http://localhost in browser  

## Run with only Docker
1. Open a terminal
2. Run:  
    * docker images
4. Make sure mrmills/lumatax-server and mrmills/lumatax-portal is present
5. Navigate to the top folder of the lumatax project
6. Run the server:  
    docker run --publish 8082:80 --env-file ./lumatax-server/lumatax-server.env mrmills/lumatax-server:1.0.0
6. Open another terminal and navigate to the top folder of the lumatax project
7. Run the angular frontend:  
    docker run --publish 80:80 --env-file ./lumatax-portal/lumatax-portal.env mrmills/lumatax-portal:1.0.0
8. Nothing will appear on the terminal
9. Open http://localhost in browser

---

## If I had more time, I would...
 * Add angular tests
 * Add server integration tests
 * Add integrated automated tests
 * Add an error message or alert box for failed or invalid file inputs on the UI
 * Redesign the database with foreign key relationship (dependent on more use cases)
 * Redesign the backend API
    * Have file upload endpoint return a UUID to identify upload instead of waiting for the file to process
    * Add endpoint to retrieve file summary results based on UUID 
 * Try out multistage Dockerfiles
