FROM nephatrine/nginx-php:testing
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== INSTALL PACKAGES ======" \
 && apk add ffmpeg imagemagick zip \
 && rm -rf /var/cache/apk/*

RUN echo "====== COMPILE H5AI ======" \
 && apk add --virtual .build-h5ai git nodejs-npm \
 && git -C /usr/src clone --depth=1 https://github.com/lrsjng/h5ai.git && cd /usr/src/h5ai \
 && npm install \
 && npm run build \
 && unzip build/*.zip -d /var/www/html/ \
 && cd /usr/src && rm -rf /usr/src/* \
 && apk del --purge .build-h5ai && rm -rf /var/cache/apk/*

RUN echo "====== CONFIGURE SYSTEM ======" \
 && mkdir -p /mnt/media \
 && sed -i 's~index.html~index.html /_h5ai/public/index.php~g' /etc/nginx/nginx.conf \
 && sed -i 's~/mnt/config/www/~/mnt/config/www/:/mnt/media/~g' /etc/php/php-fpm.d/www.conf

COPY override /