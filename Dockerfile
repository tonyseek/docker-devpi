FROM python:2.7.9-onbuild
MAINTAINER Jiangge Zhang <tonyseek@gmail.com>

EXPOSE 3141
VOLUME ["/var/lib/devpi"]

CMD ["devpi-server", "--host=0.0.0.0", "--serverdir=/var/lib/devpi"]
