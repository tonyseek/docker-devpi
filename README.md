![Docker Pulls](https://img.shields.io/docker/pulls/tonyseek/devpi.svg)
![Docker Stars](https://img.shields.io/docker/stars/tonyseek/devpi.svg)
![Docker Image Size](https://images.microbadger.com/badges/image/tonyseek/devpi.svg)

# devpi-docker

The [Docker][docker] image of [devpi][devpi] with LDAP integration.

## Quick Start

Create the data directory:

    docker run --rm --volume ./lib/devpi:/var/lib/devpi \
        tonyseek/devpi:4.4.0-1 --init

Run the server:

    docker run --rm --volume ./lib/devpi:/var/lib/devpi \
        tonyseek/devpi:4.4.0-1

## Upgrading

Export data from the volume of old container:

    docker run --rm --volume ./lib/devpi:/var/lib/devpi \
        --volume ./backup:/var/lib/devpi-backup tonyseek/devpi:$OLD_VERSION \
        --export /var/lib/devpi-backup

Import data to the volume of new container:

    docker run --rm --volume ./lib/devpi:/var/lib/devpi \
        --volume ./backup:/var/lib/devpi-backup tonyseek/devpi:4.4.0-1 \
        --import /var/lib/devpi-backup

## Development

The docker-compose makes development be easy:

    make init
    make up

Once the `requirements.in` was changed, the `requirements.txt` should be
compiled again:

    make compile-deps

More commands are described in `make help`.

## Contributing

If you want to report bugs or request features, please feel free to open
issues or pull requests on GitHub.

[devpi]: http://doc.devpi.net/latest/
[docker]: http://www.docker.com
