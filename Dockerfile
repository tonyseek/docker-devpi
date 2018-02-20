FROM python:2.7.14-slim
MAINTAINER Jiangge Zhang <tonyseek@gmail.com>

RUN mkdir /usr/local/src/devpi/
COPY requirements.txt /usr/local/src/devpi/
RUN pip install -r /usr/local/src/devpi/requirements.txt

COPY entrypoint.py /usr/local/bin/devpi-entrypoint
RUN chmod +x /usr/local/bin/devpi-entrypoint

EXPOSE 80
VOLUME ["/var/lib/devpi"]

ENTRYPOINT ["devpi-entrypoint", "--serverdir=/var/lib/devpi"]
CMD ["--host=0.0.0.0", "--port=80"]
