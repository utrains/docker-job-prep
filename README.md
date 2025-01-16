# DOCKER INTERVIEW QUESTIONS


## **DOCKER**

### **General questions**

1. What is Docker?

**Answer:** **Docker** is a containerization platform that enables developers to package an application and all its dependencies into a single entity, a container, which can be easily deployed and run on any machine that supports Docker.

2. What is a Docker container?

**Answer:** **Docker Container** is a lightweight unit that includes an application and all its dependencies.

3. Explain Virtualization

**Answer:** **Virtualization** is the process of creating a virtual version of a resource such as a server, data storage, or application.

4. Can You tell What is the Functionality of a Hypervisor?

**Answer:** **A Hypervisor** is virtualization software that allows you to run operating systems (Guest OS) on a single physical host system by separating the management of virtual machines (VMs) and their resources.

5. what makes the difference between Docker and Virtualization?

**Answer:** **Docker** allows you to run multiple applications on the same Host OS kernel while Virtualization uses Hypervisor to run complete OS instances. 

Docker lets you run an application on any operating system while A Virtualization lets you run a virtual machine on any hardware. 

6. What is a cloud-hosted service of Docker providing registry capabilities for public and private content?

**Answer:** **Docker Hub** is a cloud-hosted service that allows users to store and share container images, making it easier to manage application deployment. It includes public and private Docker images, image sharing, and official images.

7. In what Circumstances Will You Lose Data Stored in a Container? Which solution do you propose to keep your data?

**Answer:** You can lose data stored in a container whenever the container is deleted or if docker non-persistent storage ( Ephemeral storage ) is used without proper data management.

To make your data persistent, you can use docker volumes or mount volumes.

8. Where are docker volumes stored in docker?

**Answer:** Docker creates, manages, and stores its volumes at **/var/lib/docker/volumes/**

9. Describe the Lifecycle of a Docker Container.

**Answer:** A docker container can take one of the following states during its lifecycle:

- **Creation**: On using the \`**docker run**\` command, the container is created.

- **Execution**: In this state specific required commands are executed inside the container.

- **Pausing/Unpausing**: These are optional states for temporarily halting a container.

- **Stopping**: On using the \`**docker stop**\` command, the container is gracefully halted in this state.

- **Removal**: The container can be deleted using the \`**docker rm**\` command.

- **Restarting**: With the \`**docker restart**\` command containers can be restarted.

10. Can a Container Restart By Itself?

**Answer:** Yes a docker container can restart automatically by setting up the **–restart** option when creating it. Here is the command.

```
docker run --restart
```

11. What Is the Difference Between Docker Restart Policies “**no**”, “**on-failure**,” And “**always**”?

**Answer:** The restart policy “**no**” gives full control over restarts, “**on-failure**” handles irregular issues, and “**always**” will ensure constant availability.

Examples:

```
docker run -restart no my_container 
# restarts up to 3 times on failure 
docker run -restart on-failure:3 my_container 
docker run -restart always my_container
```

12. How do you monitor Docker containers?

**Answer:** Docker containers can be monitored using Docker’s built-in commands (**docker stats**, **docker logs**, etc.) or third-party tools such as Prometheus, Grafana, and Datadog.

13. What is the difference between **docker run** and **docker create**?

**Answer:** **docker run** creates and starts a container in one step, while **docker create** only creates a container without starting it

14. How Do You Limit the CPU and Memory Usage of a Docker Container?

**Answer:** You can limit the CPU and Memory Usage of a Docker Container by using the **–cpus** option to set the CPU limits and with -m option to set memory limits.

Example: set CPU limit to 2 and Memory usage to 512M

```
docker run --cpus=2 -m  512M  <image_name>
```

15. How can Docker be used in CI/CD?

**Answer:** In the CI/CD pipeline, Developers use Docker images to ensure that applications run the same way in development, testing, and production. Docker containers provide isolated environments and can be easily scaled up or down.

16.  Is it a Good Practice to Run Stateful Applications on Docker?

**Answer:** Docker is designed for stateless applications but you can carefully handle them using Docker volumes or persistent storage.

17.  How do you expose ports in a Docker container?

**Answer:** You can expose ports on a docker container using the option **-p or --publish** with the docker run command.

```
docker run -p 8080:80 mycontainer
```

18.  How do you pass environment variables to a Docker container?

**Answer**: Environment variables can be passed to a Docker container using the **-e** or **--env** option with the docker run command.

19.  What is the difference between a base image and a child image in Docker?

**Answer:** the child image has the base image's contents along with additional layers defined in the child image's Dockerfile

20.  What is the purpose of the "docker exec" command?

**Answer:** the docker exec command is used to run a command within a running docker container. It opens a shell session within a running container to execute commands.


### **Experimental questions**

21.  Which is the best method for removing a container: the command to “stop container” followed by the command to “remove the container,” or the rm -f command by itself?

**Answer:** It depends on the situation. Each situation has its pros and cons:

1. Stop the container, then remove it

Pros: 

- Prevents potential data corruption or unfinished tasks if the container is doing something important.

- Provides a clean shutdown, allowing the container to release resources gracefully

Cons:

- Requires two steps, which can be slightly less efficient if you need to remove multiple containers.

2. Use the **rm -f** command to remove a container

Pros:

- More efficient because it combines stopping and removing into one command.

- Ideal for situations where containers are misbehaving or are stuck in a non-responsive state.

Cons:

- May not be suitable for containers with tasks that need to finish properly before shutting down.

22.  Suppose You Have 3 Containers Running, and Out Of These, You Wish to Access One Of Them. How Do You Access a Running Container?

**Answer:** To access one of the running containers, you need to know the container ID using the “**docker ps**” command, then you can use the “docker exec” command to connect to it

General syntax:

```
docker ps docker exec -it <container_id_or_name> /bin/bash
```

23.  Considering a Server With 16 GB RAM and a Quad-core CPU, What Factors Determine the Maximum Number Of Containers You Can Run on the Host for a Microservices App?

**Answer:** To determine the maximum number of containers you can run on a host, you need to know the available RAM and CPU capacity and one container of the Microservices App needs. Then, you can divide the available capacity by the capacity required by a container

Example: With the 16 GB of RAM available, assuming each container utilizes 512 MB efficiently, you could run on nearly 32 containers.

24.  How Will You Monitor Docker in Production?

**Answer:** To monitor Docker in production, you can use tools like Docker Stats, cAdvisor, and Prometheus to retrieve real-time insights for container performance.

25.  How Do You Share Data Between Containers in Docker?

**Answer:** Docker volumes can provide persistent and shared storage that can be accessed and modified across multiple containers using the option “**--volumes-from**” 

26.  What is the purpose of the CMD instruction in a Dockerfile?

**Answer:** the CMD instruction in a Dokerfile is used to define commands that will execute when the docker container will run.

27.  What is the difference between COPY and ADD instructions in a Dockerfile

**Answer:** In a Dockerfile, the **COPY** instruction copies files or directories from the host machine to the container's filesystem while the **ADD** instruction has additional capabilities. It can copy local files, extract compressed archives into the container, and even download files from URLs and automatically unpack them.


## **DOCKER-COMPOSE**

### **General questions**

1. What’s Docker-compose?

**Answer:** **Docker-compose** is a tool that helps you define, share and run multi-container applications.

2. What is the syntax of a docker-compose file?

**Answer:** A Docker-Compose file uses the YAML syntax.

3. Can I use JSON instead of YAML for the docker-compose file?

**Answer:** Yaml is a superset of JSON so any JSON file should be valid Yaml. To use a JSON file with Compose, specify the filename to use.

Example:  ``` docker compose -f docker-compose.json up ```

4. What is the difference between **docker-compose up** and **docker-compose up -d**?

**Answer: docker compose up** command starts the services in the foreground, displaying logs in the terminal while **docker compose up -d** runs the services in detached mode (in the background).

5. What is the difference between **docker run** and **docker compose up**?

**Answer:** **docker run** is used to start a single container, while **docker compose up** is used to start multiple containers defined in a Docker compose file.

6. What is the difference between docker compose up and docker compose start?

Answer: docker compose up is used to start all the containers defined in a docker-compose file, while docker-compose start is used to start one or more stopped containers.

7. How do you scale a Docker compose service?

**Answer:** To scale a Docker Compose service, you can use the **docker compose up** command with the **--scale** option, followed by the service name and the desired number of instances.

Syntax of the command:

```
docker-compose up --scale <service_name> <number_of_instances>
```

### **Experimental questions**

8. How Will You Ensure Container 1 Runs Before Container 2 While Using Docker Compose?

**Answer:** In docker-compose, you can specify the order of services start up using the option **depends_on** in the docker-compose YAML file.

Example of syntax: In this example of code, container2 will start before container1 due to the **depends_on** option, even if the container1 definition is coming before container2.

```
services:   container1:     depends_on:      - container2    ...   container2:   ....
```

9. How does Docker Compose handle networking between services by default?

**Answer:** Docker Compose creates a default network for all services. Services can communicate with each other using their service name as the hostname.

Let’s take an example, you are creating an application called **web_app** with the following docker-compose.yml

```
services:   web:     build: .     ports:       - "8000:8000"   db:     image: postgres     ports:       - "8001:5432"
```

When starting your application with **docker compose up**, what happen?

- A network called **web_app_default** is created.

- A container is created using web's configuration. It joins the network **web_app_default** under the name **web**.

- A container is created using db's configuration. It joins the network **web_app_default** under the name **db**.

At this point, each container can interact with the other container. For example the **web** service can connect to URL: postgres\://db:5432 and start using the postgres database. 



## **DOCKER SWARM**

### **General questions**

1. What is the purpose of Docker container orchestration?

**Answer:** Docker container orchestration is used to manage, scale, and deploy multiple containers across a cluster of machines in an automated way with a distributed environment.

2. What’s Docker Swarm?

**Answer:** Docker swarm is a container orchestration tool for clustering and scheduling Docker containers

3. What’s the difference between Docker compose and Docker swarm?

**Answer:** 

- Docker Compose manages containers on a single host, while Docker Swarm is designed for container orchestration across multiple hosts.

- Docker Compose is ideal for local development and defining multi-container applications, while Docker Swarm shines in orchestrating and managing containerized applications at scale across multiple nodes

4. How do you create a Docker Swarm cluster?

**Answer:** 

These are the steps to create a Docker Swarm cluster:

1. Initialize a Swarm on the manager node using the command: 

```
docker swarm init
```

2. Join worker nodes to the Swarm by running the command provided by the previous step on each worker node.

3. Verify the cluster status by executing the following command on the manager node:

```
docker node ls
```

4. It should show the manager and worker nodes as part of the Swarm.

5. You now have a functioning Docker Swarm cluster and you can deploy and manage services using Swarm features.


### **Experimental questions**

5. How do you scale Docker containers horizontally?

**Answer:** To scale Docker containers horizontally, you can leverage **Docker Swarm** or a container orchestration platform like **Kubernetes**. Docker Swarm allows you to form a cluster of Docker nodes and scale services by setting the number of replicas. 

For instance, using the command docker service scale myservice=5 would scale the specified service, myservice, to 5 replicas across the cluster.

6. How do you perform rolling updates with Docker Compose?

**Answer:** To perform rolling updates with Docker Compose, you can follow these steps:

- **Define the Docker Compose File:** Start by setting up a **docker-compose.yml** file that specifies your services, their configurations, and the desired number of replicas.

- **Set the Update Strategy:** Although Docker Compose doesn’t natively support rolling updates outside of Swarm mode, you can achieve this by defining replicas and updating containers incrementally.

- **Update Docker Images:** Build or pull the updated images for each service.

- **Scale Services with docker-compose up:** Run docker-compose up with the --scale option to adjust replicas to your desired level. This approach helps you bring up the new version incrementally while keeping the previous ones running to ensure continuity.

- **Monitor the Update:** Use the Docker Compose CLI or monitoring tools to track the update progress, ensuring that the specified replicas stay running throughout the update.
