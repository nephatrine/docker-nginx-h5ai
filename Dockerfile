FROM nephatrine/nginx-lemp:latest
LABEL maintainer="Daniel Wolf <nephatrine@gmail.com>"

RUN echo "====== NOT MUCH TO DO ======" \
 && apk --update upgrade \
 && mkdir -p /mnt/media \
 \
 && echo "====== PREPARE BUILD TOOLS ======" \
 && apk add --virtual .build-h5ai nodejs-npm \
 \
 && echo "====== INSTALL H5AI ======" \
 && cd /usr/src \
 && git clone https://github.com/lrsjng/h5ai.git && cd h5ai \
 && npm install && npm run build \
 && unzip build/*.zip -d /var/www/html/ \
 \
 && echo "====== CLEANUP ======" \
 && cd /usr/src \
 && apk del --purge .build-h5ai \
 && rm -rf \
  /tmp/* \
  /usr/src/* \
  /var/cache/apk/*

COPY override /