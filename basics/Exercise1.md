# Exercise 1: Managing containers
In this exercise, we'll learn the basics of pulling images, starting, stopping, and removing containers.

Pulling an image
To run containers, we'll first need to pull some images.

## Let's see what images we have currently on our machine, by running docker images:

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```

On a fresh Docker installation, we should have no images. Let's pull one from Dockerhub.

We usually pull images from DockerHub by tag. These look like:

```
# Official Docker images
<repo>:<tag>
# httpd:2.4.62
# ubuntu:16.04
# nginx:latest

# User or organization made images
<user or org>/<repo>:<tag>
# grafana/grafana:latest-ubuntu
# delner/ubuntu:16.04
# bitnami/rails:latest
```
We can search for images using docker search <keyword>

```
$ docker search httpd

NAME                     DESCRIPTION                                     STARS     OFFICIAL
httpd                    The Apache HTTP Server Project                  4819      [OK]
manageiq/httpd           Container with httpd, built on CentOS for Ma…   1         
paketobuildpacks/httpd                                                   0         
vulhub/httpd                                                             0         
jitesoft/httpd           Apache httpd on Alpine linux.                   0         
openquantumsafe/httpd    Demo of post-quantum cryptography in Apache …   14        
openeuler/httpd                                                          0         
dockerpinata/httpd                                                       1         
centos/httpd                                                             36    

```
You can also find images online at DockerHub.

Run docker pull ubuntu:16.04 to pull an image of Ubuntu 16.04 from DockerHub.

```
$ docker pull ubuntu:16:04

16.04: Pulling from library/ubuntu
8aec416115fd: Pull complete 
695f074e24e3: Pull complete 
946d6c48c2a7: Pull complete 
bc7277e579f0: Pull complete 
2508cbcde94b: Pull complete 
Digest: sha256:71cd81252a3563a03ad8daee81047b62ab5d892ebbfbf71cf53415f29c130950
Status: Downloaded newer image for ubuntu:16.04
We can also pull different versions on the same image.

```

Run docker pull ubuntu:16.10 to pull an image of Ubuntu 16.10.

```
16.10: Pulling from library/ubuntu
3a635c0fcefb: Pull complete 
bf3f7e9b4869: Pull complete 
ad323864e1f8: Pull complete 
b4d3fc870200: Pull complete 
4e69d6ff0e56: Pull complete 
Digest: sha256:609c1726180221d95a66ce3ed1e898f4a543c5be9ff3dbb1f10180a6cb2a6fdc
Status: Downloaded newer image for ubuntu:16.10
```

Then when we run 'docker images' again, we should get:

```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              16.10               7d3f705d307c        7 years ago         107MB
ubuntu              16.04               b6f507652425        3 years ago         135MB
Over time, your machine can collect a lot of images, so it's nice to remove unwanted images.
```

Run docker rmi <IMAGE ID> to remove the Ubuntu 16.10 image we won't be using.

```
$ docker rmi 7d3f705d307c

Untagged: ubuntu:16.10
Untagged: ubuntu@sha256:609c1726180221d95a66ce3ed1e898f4a543c5be9ff3dbb1f10180a6cb2a6fdc
Deleted: sha256:31005225a74578ec48fbe5a833ef39a3e41ebcbf0714ad3867070405b3efd81e
Deleted: sha256:c9fcffc56240d2382f78da3130215afcfc7130b29210184f30ffce3a3eae677d
Deleted: sha256:7a8ffa53e9616698d138da12474f8f7441f00e129bb06c7f12b9264828bcad1e
Deleted: sha256:c71fbd03fa070b80919b1712f7b335829fecd0157915cf4b60775988c18a5687
Deleted: sha256:3b1d2c1b8ae337cacea8271862bded89d920bbbf5049fa1b4927169cb3b3974c
Deleted: sha256:6b720ab3505cb593509654fac976193e75bc881d9c72abdffe4c29278396c636

```

Alternatively, you can delete images by tag or by a partial image ID. In the previous example, the following would have been equivalent:

```
$ docker rmi 7d
$ docker rmi ubuntu:16.10

```

Running docker images should reflect the deleted image.

```
$ docker images

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              16.04               b6f507652425        3 years ago         135MB

```

To remove all docker images on your system, use the following command:

```
docker rmi $(docker images -a -q)

```

Running our container

Let's do a very simple example. Run: docker run ubuntu:16.04 /bin/echo 'Welcome to Docker preparation day !!'

```
$ docker run ubuntu:16.04 /bin/echo 'Welcome to Docker preparation day !!'

Welcome to Docker preparation day !!
The /bin/echo command is a really simple application that just prints whatever you give it to the terminal. We passed it 'Welcome to Docker preparation day !! ', so it prints Welcome to Docker preparation day !! to the terminal.

```

When you run the whole docker run command, it creates a new container from the image specified, then runs the command inside the container. From the previous example, the Docker container started, then ran the /bin/echo command in the container.

Let's check what containers we have after running this. Run the command: docker ps

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

```

That's strange: no containers right? The ps command doesn't show stopped containers by default, add the -a flag.

```
$ docker ps -a

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                      PORTS     NAMES
44d643f1fe59   ubuntu:16.04   "/bin/echo 'Welcome …"   40 seconds ago   Exited (0) 38 seconds ago             nostalgic_ellis

Okay, there's our container. But why is the status "Exited"?

```

Docker containers only run as long as the command it starts with is running. In our example, it ran /bin/echo successfully, printed some output, then exited with status code 0 (which means no errors.) When Docker saw this command exit, the container stopped.

Let's do something a bit more interactive. Run the command: docker run ubuntu:16.04 /bin/bash

```
$ docker run ubuntu:16.04 /bin/bash
$

```

Notice nothing happened. When we run docker ps -a

```
$ docker ps -a

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                      PORTS     NAMES
525e4429fac6   ubuntu:16.04   "/bin/bash"              41 seconds ago   Exited (0) 40 seconds ago             loving_carson
44d643f1fe59   ubuntu:16.04   "/bin/echo 'Welcome …"   3 minutes ago    Exited (0) 3 minutes ago              nostalgic_ellis

The container exited instantly. Why? We were running the /bin/bash command, which is an interactive program. However, the docker run command doesn't run interactively by default, therefore the /bin/bash command exited, and the container stopped.

```

Instead, let's add the -it flags, which tells Docker to run the command interactively with your terminal.

```
$ docker run -it ubuntu:16.04 /bin/bash
root@537bf1d0cdab:/#
This looks a lot better. This means you're in a BASH session inside the Ubuntu container. Notice you're running as root and the container ID that follows.
```

You can now use this like a normal Linux shell. Try pwd and ls to look at the file system.

```
root@537bf1d0cdab:/# pwd
/
root@537bf1d0cdab:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

```

You can type exit to end the BASH session, terminating the command and stopping the container.

```
root@537bf1d0cdab:/# exit
exit
$
```

By default your terminal remains attached to the container when you run `docker run`. What if you don't want to remain attached?

By adding the `-d` flag, we can run in detached mode, meaning the container will continue to run as long as the command is, but it won't print the output.

Let's run `/bin/sleep 1200`, which will run the container idly for 20 minutes:

```
$ docker run -d ubuntu:16.04 /bin/sleep 1200
ab466725bc1c7fe5669022e398b95e5937dffb358926cd25290db73290ffd7e3
$

```

If we check the container, we can see it's running the sleep command in a new container.

```
$ docker ps
CONTAINER ID   IMAGE          COMMAND             CREATED          STATUS          PORTS     NAMES
ab466725bc1c   ubuntu:16.04   "/bin/sleep 1200"   51 seconds ago   Up 50 seconds             vibrant_wilson
$

```

Now that the container is running in the background, what if we want to reattach to it?

Conceivably, if this were something like a web server or other process where we might like to inspect logs while it runs, it'd be useful to run something on the container without interrupting the current process.

To this end, there is another command, called `docker exec`. `docker exec` runs a command within a container that is already running. It works exactly like `docker run`, except instead of taking an image ID, it takes a container ID.

This makes the `docker exec` command useful for tailing logs, or "SSHing" into an active container.

Let's do that now, running the following, passing the first few characters of the container ID:

```
$ docker exec -it ab4 /bin/bash
root@ab466725bc1c:/#

```

The container ID appearing at the front of the BASH prompt tells us we're inside the container. Once inside a session, we can interact with the container like any SSH session.

Let's list the running processes:

```
root@ab466725bc1c:/# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   4380  1280 ?        Ss   17:52   0:00 /bin/sleep 1200
root           7  0.0  0.0  18240  3072 pts/0    Ss   18:04   0:00 /bin/bash
root          17  0.0  0.0  34428  2816 pts/0    R+   18:05   0:00 ps aux
root@ab466725bc1c:/# 

```

There we can see our running `/bin/sleep 1200` command. Whenever we're done, we can type `exit` to exit our current BASH session, and leave the container running.

```
root@ab466725bc1c:/# exit
exit
$ docker ps
CONTAINER ID   IMAGE          COMMAND             CREATED          STATUS          PORTS     NAMES
ab466725bc1c   ubuntu:16.04   "/bin/sleep 1200"   14 minutes ago   Up 14 minutes             vibrant_wilson
$
```

And finally checking `docker ps`, we can see the container is still running.

Instead of waiting 20 minutes for this command to stop (and the container exit), what if we'd like to stop the Docker container now?

To that end, we have the `docker stop` and the `docker kill` commands. The prior is a graceful stop, whereas the latter is a forceful one.

Let's use `docker stop`, passing it the first few characters of the container name we want to stop.

```
$ docker stop ab46
ab46

```

Then checking `docker ps -a`...

```
$ docker ps -a

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                        PORTS     NAMES
ab466725bc1c   ubuntu:16.04   "/bin/sleep 1200"        16 minutes ago   Exited (137) 23 seconds ago             vibrant_wilson

$
```

We can see that it exited with code `137`, which in Linux world means the command was likely aborted with a `kill -9` command.


### Removing containers

After working with Docker containers, you might want to delete old, obsolete ones.

```
$ docker ps -a

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                        PORTS     NAMES
ab466725bc1c   ubuntu:16.04   "/bin/sleep 1200"        16 minutes ago   Exited (137) 23 seconds ago             vibrant_wilson

$
```

From our previous example, we can see with `docker ps -a` that we have a container hanging around.

To remove this, we can use the `docker rm` command which removes stopped containers.

```
$ docker rm ab46
ab46

```

A nice shortcut for removing all containers from your system is `docker rm $(docker ps -a -q)`

It can be tedious to remove old containers each time after you run them. To address this, Docker also allows you to specify the `--rm` flag to the `docker run` command, which will remove the container after it exits.

```
$ docker run --rm ubuntu:16.04 /bin/echo 'Welcome to Docker preparation day !!'
Welcome to Docker preparation day !!

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

$

```



