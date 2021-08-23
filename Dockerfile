FROM nephatrine/nginx-php:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

ARG H5AI_VERSION=0.31.0
RUN echo "====== COMPILE H5AI ======" \
 && apk add \
  ffmpeg \
  imagemagick \
  zip \
 && apk add --virtual .build-h5ai \
  git \
  npm \
 && git -C /usr/src clone -b "$H5AI_VERSION" --single-branch --depth=1 https://github.com/glubsy/h5ai.git && cd /usr/src/h5ai \
 && npm install \
 && npm run build \
 && unzip build/*.zip -d /var/www/html/ \
 && mkdir -p /mnt/media \
 && sed -i 's~index.html~index.html /_h5ai/public/index.php~g' /etc/nginx/nginx.conf \
 && sed -i 's~/mnt/config/www/~/mnt/config/www/:/mnt/media/~g' /etc/php/php-fpm.d/www.conf \
 && cd /usr/src && rm -rf /usr/src/* \
 && apk del --purge .build-h5ai && rm -rf /var/cache/apk/*

COPY override /
