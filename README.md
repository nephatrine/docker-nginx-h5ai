[Git Repo](https://code.nephatrine.net/nephatrine/docker-h5ai) |
[DockerHub](https://hub.docker.com/r/nephatrine/h5ai/) |
[unRAID Template](https://github.com/nephatrine/unraid-docker-templates)

# H5AI Container

This docker container manages the H5AI application, a lightweight web directory index.

- [H5AI](https://larsjung.de/h5ai/)

## Configuration

- ``{config}/etc/crontab``: Crontab Entries
- ``{config}/etc/logrotate.conf``: Logrotate General Configuration
- ``{config}/etc/logrotate.d/*``: Logrotate Per-Application Configuration
- ``{config}/etc/mime.types``: NGINX MIME Types
- ``{config}/etc/nginx.conf``: NGINX General Configuration
- ``{config}/etc/nginx.d/*``: NGINX Per-Site Configuration
- ``{config}/etc/php.d/*``: PHP Extension Configuration
- ``{config}/etc/php.ini``: PHP General Configuration
- ``{config}/etc/php-fpm.conf``: PHP-FPM General Configuration
- ``{config}/etc/php-fpm.d/*``: PHP-FPM Per-Site Configuration
- ``{config}/ssl/live/{site}/``: SSL/TLS certificates
- ``{media}/_h5ai/private/conf/options.json``: H5AI Configuration

**Remember to change the password in the h5ai configuration as the info page might expose information about your server that you do not want exposed.**

Just put files and folders into the volume mapped to `/mnt/media` and they will be made accessible through the web interface. For private files, you can either lock them down via the NGINX config (there's an example that will hide files under /local/) or use a container that is not publicly accessible in the first place.

Certbot is included for requestung SSL certificates but you are better off just enabling HTTP from these containers and then using a single [docker-nginx-ssl](https://code.nephatrine.net/nephatrine/docker-nginx-ssl) container as a reverse proxy and handling all the HTTPS/SSL configuration there.

## Ports

- **80/tcp:** HTTP Port
- **443/tcp:** HTTPS Port

## Variables

- **PUID:** Owner UID (*1000*)
- **PGID:** Owner GID (*100*)
- **TZ:** Time Zone (*"America/New_York"*)

- **DNSADDR:** Resolver IPs ("8.8.8.8 8.8.4.4") (IGNORED AFTER INITIAL RUN) (SPACE-DELIMITED)

- **ADMINIP**: Administrator IP ("127.0.0.1") (IGNORED AFTER INITIAL RUN)
- **TRUSTSN:** Trusted Subnet ("192.168.0.0/16") (IGNORED AFTER INITIAL RUN)

- **SSLEMAIL:** LetsEncrypt Email ("")
- **SSLDOMAINS:** LetsEncrypt Domains ("") (COMMA-DELIMITED)

## Mount Points

- **/mnt/config:** Configuration/Logs
- **/mnt/media:** Indexed Files

The media mountpoint will have an `_h5ai` folder created in it, but otherwise will not be modified.