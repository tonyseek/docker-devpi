FROM python:2.7.9-onbuild
MAINTAINER Jiangge Zhang <tonyseek@gmail.com>

EXPOSE 80
VOLUME ["/var/lib/devpi"]

CMD ["devpi-server", "--host=0.0.0.0", "--port=80", "--serverdir=/var/lib/devpi"]
