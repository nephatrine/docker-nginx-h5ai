FROM nephatrine/alpine:builder AS builder

ARG H5AI_VERSION=0.31.0
RUN git -C /usr/src clone -b "$H5AI_VERSION" --single-branch --depth=1 https://github.com/glubsy/h5ai.git

RUN echo "====== COMPILE H5AI ======" \
 && cd /usr/src/h5ai \
 && npm install && npm run build \
 && mkdir -p /var/www/html/ \
 && unzip build/*.zip -d /var/www/html/

FROM nephatrine/nginx-php:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== INSTALL PACKAGES ======" \
 && apk add --no-cache ffmpeg imagemagick zip \
 && sed -i 's~/mnt/config/www/~/mnt/config/www/:/mnt/media/~g' /etc/php/php-fpm.d/www.conf \
 && sed -i 's~index.html~index.html /_h5ai/public/index.php~g' /etc/nginx/nginx.conf \
 && mkdir -p /mnt/media

COPY --from=builder /var/www/html/ /var/www/html/
COPY override /
