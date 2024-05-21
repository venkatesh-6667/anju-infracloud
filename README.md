
### CSV Server Container Setup

This project provides instructions and scripts to set up a containerized CSV server application using `infracloudio/csvserver:latest`, along with Prometheus for monitoring. Follow the steps below to get the application running and accessible with specific configurations.

## Prerequisites

- Docker installed on your system.
- Docker Compose installed on your system.
- Basic understanding of bash scripting.
- Git installed on your system.

## Steps

# Part 1: Running the Container Directly with Docker

1.Clone the Repository

- Clone the `csvserver` repository to get the necessary files:

       git clone https://github.com/infracloudio/csvserver.git

       cd csvserver

- Pull the container image infracloudio/csvserver:latest:

       docker pull infracloudio/csvserver:latest

- Run the container image in the background:


       docker run -d --name csvserver infracloudio/csvserver:latest

2.Check if it's running:

        docker ps

- If the container is failing, inspect the logs to find the reason:


       docker logs csvserver

3.Generate inputdata Using gencsv.sh

   Save this script as gencsv.sh and make it executable:

        chmod +x gencsv.sh

- Run the script to generate inputdata:


       ./gencsv.sh 2 8

4.Run the container again with inputdata available inside the container:

         docker run -d -v "$(pwd)/inputdata:/csvserver/inputdata" infracloudio/csvserver:latest

   Copy the container ID by running:


         docker ps -a

5.Copy the container ID and get shell access to the running container:

         docker exec -it <container_id> /bin/bash

- Inside the container, find the port on which the application is listening:

          netstat -tuln

6.Run the Container with Port Mapping and Environment Variable

- Run the container ensuring the application is accessible on the host at http://localhost:9393 and set the environment variable CSVSERVER_BORDER to Orange:


          docker run -d -p 9393:9300 -e CSVSERVER_BORDER=Orange -v "$(pwd)/inputdata:/csvserver/inputdata" infracloudio/csvserver:latest

- Stop and remove the running container:


         docker stop <container_id>
         docker rm <container_id>

  Check the container status:

         docker ps

- Verify the desired result by accessing http://localhost:9393.


- Save the above generated files gencsv.sh, inputFile, part-1-cmd, part-1-output, part-1-logs.


## Part 2: Running the Container with Docker Compose

1.Stop and remove any containers from the previous part:

         docker-compose down

2.Create a docker-compose.yaml and

3.Create csvserver.env file for the requirement

- Ensure the generated inputdata using the gencsv.sh script from Part 1:


         ./gencsv.sh 2 8

4.Run the application using Docker Compose:


          docker-compose up -d

- #Verify the Application
   Open any browser and navigate to http://localhost:9393 to verify:
   The application displays 7 entries from inputdata.
   The welcome note has an orange color border.



## Part 3: Adding Prometheus for Monitoring

1.Stop and remove any containers from the previous part:
    
         docker-compose down

2.Update docker-compose.yaml to include a Prometheus service:
   Create a Prometheus configuration file named prometheus.yml
   Ensure you have generated the inputdata using the gencsv.sh script from Part 1:


         ./gencsv.sh 2 8

 - Run the application using Docker Compose:


         docker-compose up -d

3.Verify Prometheus
  
  Open any browser and navigate to http://localhost:9090 to verify Prometheus is running.

4.In Prometheus, type csvserver_records in the query box,click on Execute,then it switches to the Graph tab.


 #Cleanup
  To stop and remove the running containers:
 
          docker-compose down





