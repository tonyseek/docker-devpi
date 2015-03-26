# devpi-docker

## Introduction

Host your private PyPI server by running [devpi][devpi] as a [Docker][docker]
container.

## Usage

    docker run -d --name=devpi -p 80:80 tonyseek/devpi:2.1.5-1

## Upgrading

For example, to upgrade devpi from `2.1.3-1` to `2.1.5-1`, we need to:

1. Update the docker image:

       docker pull tonyseek/devpi:2.1.5-1

2. Stop the running container:

       docker stop devpi

2. Export data to a new container:

       BACKUP_DIR=/var/lib/devpi-upgrade
       docker run --name=devpi-upgrade --volume=$BACKUP_DIR --volumes-from=devpi tonyseek/devpi:2.1.3-1 --export=$BACKUP_DIR

3. Import data from that container using new image:

       docker run --rm --volumes-from=devpi-upgrade --volumes-from=devpi tonyseek/devpi:2.1.5-1 --import=$BACKUP_DIR

4. Remove the old container and create the new one:

       docker run --name=devpi-data --volumes-from=devpi busybox true
       docker rm devpi
       docker run -d --name=devpi -p 80:80 tonyseek/devpi:2.1.5-1

5. Check the new devpi on its website and remove useless containers:

       docker rm devpi-data devpi-upgrade

[devpi]: http://doc.devpi.net/latest/
[docker]: http://www.docker.com
