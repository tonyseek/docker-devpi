FROM python:2.7.9-onbuild
MAINTAINER Jiangge Zhang <tonyseek@gmail.com>

EXPOSE 80
VOLUME ["/var/lib/devpi"]

ENTRYPOINT ["devpi-server", "--serverdir=/var/lib/devpi"]
CMD ["--host=0.0.0.0", "--port=80"]
