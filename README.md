# devpi-docker

## Introduction

Host your private PyPI server by running [devpi][devpi] as a [Docker][docker]
container.

## Usage

    docker run -d --name=devpi -p 80:80 tonyseek/devpi:2.1.3-1

[devpi]: http://doc.devpi.net/latest/
[docker]: http://www.docker.com
