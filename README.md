[Git](https://code.nephatrine.net/NephNET/docker-nginx-h5ai/src/branch/master) |
[Docker](https://hub.docker.com/r/nephatrine/nginx-h5ai/) |
[unRAID](https://code.nephatrine.net/NephNET/unraid-containers)

# NGINX H5AI Web Index

This docker container manages the NGINX application with the H5AI PHP web
server index application.

The `latest` tag points to version `0.31.0-glubsy` and this is the only image
actively being updated. There are tags for older versions, but these may no
longer be using the latest NGINX version, PHP version, or Alpine version and
packages.

If using this as a standalone web server, you can configure TLS the same way as
the [nginx-ssl](https://code.nephatrine.net/NephNET/docker-nginx-ssl) container.
If part of a larger envinronment, we suggest using a separate container as a
reverse proxy server and handle TLS there instead.

**Remember to change the password in the h5ai configuration as the info page might expose information about your server that you do not want exposed.**

## Docker-Compose

This is an example docker-compose file:

```yaml
services:
  h5ai:
    image: nephatrine/nginx-h5ai:latest
    container_name: h5ai
    environment:
      TZ: America/New_York
      PUID: 1000
      PGID: 1000
      ADMINIP: 127.0.0.1
      TRUSTSN: 192.168.0.0/16
      DNSADDR: "8.8.8.8 8.8.4.4"
    ports:
      - "8080:80/tcp"
    volumes:
      - /mnt/containers/h5ai:/mnt/config
      - /mnt/containers/public:/mnt/media
```

## Publishing Files

Just put files and folders into the volume mapped to `/mnt/media` and they will
be made accessible through the web interface. For private files, you can either
lock them down via the NGINX config or use a container that is not publicly
accessible in the first place.

## Server Configuration

These are the configuration and data files you will likely need to be aware of
and potentially customize.

- `/mnt/config/etc/mime.type`
- `/mnt/config/etc/nginx.conf`
- `/mnt/config/etc/nginx.d/*`
- `/mnt/config/www/default/*`
- `/mnt/config/etc/php.d/*`
- `/mnt/config/etc/php.ini`
- `/mnt/config/etc/php-fpm.conf`
- `/mnt/config/etc/php-fpm.d/*`
- `/mnt/media/_h5ai/private/conf/options.json`

Modifications to some of these may require a service restart to pull in the
changes made.
