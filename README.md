[Git](https://code.nephatrine.net/nephatrine/docker-nginx-h5ai) |
[Docker](https://hub.docker.com/r/nephatrine/nginx-h5ai/) |
[unRAID](https://code.nephatrine.net/nephatrine/unraid-containers)

[![Build Status](https://ci.nephatrine.net/api/badges/nephatrine/docker-nginx-h5ai/status.svg?ref=refs/heads/testing)](https://ci.nephatrine.net/nephatrine/docker-nginx-h5ai)

# H5AI Web Index

This docker container manages the NGINX application with the H5AI PHP web
server index application.

Just put files and folders into the volume mapped to `/mnt/media` and they will
be made accessible through the web interface. For private files, you can either
lock them down via the NGINX config or use a container that is not publicly
accessible in the first place.

If using this as a standalone web server, you can configure TLS the same way as
the [nginx-ssl](https://hub.docker.com/r/nephatrine/nginx-ssl/) container. If
part of a larger envinronment, we suggest using a separate container as a
reverse proxy server and handle TLS there rather than here.

- [NGINX](https://www.nginx.com/)
- [PHP](https://www.php.net/)
- [H5AI](https://larsjung.de/h5ai/)

You can spin up a quick temporary test container like this:

~~~
docker run --rm -p 80:80 -it nephatrine/nginx-h5ai:latest /bin/bash
~~~

This container is primarily intended to be used as a base container for PHP web
applications.

**Remember to change the password in the h5ai configuration as the info page might expose information about your server that you do not want exposed.**

## Docker Tags

- **nephatrine/nginx-h5ai:testing**: H5AI Master
- **nephatrine/nginx-h5ai:latest**: H5AI 0.30.0
- **nephatrine/nginx-h5ai:0.30**: H5AI 0.30.0

## Configuration Variables

You can set these parameters using the syntax ``-e "VARNAME=VALUE"`` on your
``docker run`` command. Some of these may only be used during initial
configuration and further changes may need to be made in the generated
configuration files.

- ``ADMINIP``: Administrator IP (*127.0.0.1*) (INITIAL CONFIG)
- ``DNSADDR``: Resolver IPs (*8.8.8.8 8.8.4.4*) (INITIAL CONFIG)
- ``PUID``: Mount Owner UID (*1000*)
- ``PGID``: Mount Owner GID (*100*)
- ``TRUSTSN``: Trusted Subnet (*192.168.0.0/16*) (INITIAL CONFIG)
- ``TZ``: System Timezone (*America/New_York*)

## Persistent Mounts

You can provide a persistent mountpoint using the ``-v /host/path:/container/path``
syntax. These mountpoints are intended to house important configuration files,
logs, and application state (e.g. databases) so they are not lost on image
update.

- ``/mnt/config``: Persistent Data.
- ``/mnt/media``: Indexed Location.

Do not share ``/mnt/config`` volumes between multiple containers as they may
interfere with the operation of one another.

The ``/mnt/media/`` volume will have an `_h5ai` folder created in it, but
otherwise will not be modified.

You can perform some basic configuration of the container using the files and
directories listed below.

- ``/mnt/config/etc/crontabs/<user>``: User Crontabs.
- ``/mnt/config/etc/logrotate.conf``: Logrotate Global Configuration.
- ``/mnt/config/etc/logrotate.d/``: Logrotate Additional Configuration.
- ``/mnt/config/etc/mime.type``: NGINX MIME Types.
- ``/mnt/config/etc/nginx.conf``: NGINX Configuration.
- ``/mnt/config/etc/nginx.d/``: NGINX Configuration.
- ``/mnt/config/etc/php.d/*``: PHP Extension Configuration
- ``/mnt/config/etc/php.ini``: PHP General Configuration
- ``/mnt/config/etc/php-fpm.conf``: PHP-FPM General Configuration
- ``/mnt/config/etc/php-fpm.d/*``: PHP-FPM Per-Site Configuration
- ``/mnt/media/_h5ai/private/conf/options.json``: H5AI Configuration

**[*] Changes to some configuration files may require service restart to take
immediate effect.**

## Network Services

This container runs network services that are intended to be exposed outside
the container. You can map these to host ports using the ``-p HOST:CONTAINER``
or ``-p HOST:CONTAINER/PROTOCOL`` syntax.

- ``80/tcp``: HTTP Server. This is the default insecure web server.
