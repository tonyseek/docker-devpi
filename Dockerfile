FROM python:2.7.10-slim
MAINTAINER Jiangge Zhang <tonyseek@gmail.com>

RUN mkdir /usr/local/src/devpi/
COPY requirements.txt /usr/local/src/devpi/
RUN pip install -r /usr/local/src/devpi/requirements.txt

EXPOSE 80
VOLUME ["/var/lib/devpi"]

ENTRYPOINT ["devpi-server", "--serverdir=/var/lib/devpi"]
CMD ["--host=0.0.0.0", "--port=80"]
