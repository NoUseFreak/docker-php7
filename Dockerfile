FROM ubuntu-upstart:14.04

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C \
 	&& echo "deb http://ppa.launchpad.net/nginx/development/ubuntu trusty main" > /etc/apt/sources.list.d/nginx-development.list

RUN apt-get update \
	&& apt-get install -y \
	    aufs-tools \
	    automake \
	    bison \
	    btrfs-tools \
	    build-essential \
	    curl \
	    git \
	    libbz2-dev \
	    libcurl4-openssl-dev \
	    libmcrypt-dev \
	    libxml2-dev \
	    re2c \
	    nginx

# get the latest PHP source from master branch
RUN git clone --depth=1 https://github.com/php/php-src.git /usr/local/src/php

# # we're going to be working out of the PHP src directory for the compile steps
WORKDIR /usr/local/src/php
ENV PHP_DIR /usr/local/php

# # configure the build
RUN ./buildconf \
	&& ./configure --enable-fpm --with-mysql --prefix=$PHP_DIR --with-config-file-path=$PHP_DIR --with-config-file-scan-dir=$PHP_DIR/conf.d --with-libdir=/lib/x86_64-linux-gnu \
	&& make && make install \
	&& cp php.ini-development /usr/local/php/php.ini \
	&& cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
	&& cp sapi/fpm/php-fpm /usr/local/bin

COPY conf/init.nginx.conf /etc/init/nginx.conf
COPY conf/init.php-fpm.conf /etc/init/php-fpm.conf
COPY conf/nginx.conf /etc/nginx/sites-enabled/default
COPY conf/php.pool.conf /usr/local/php/etc/php-fpm.d/www.conf


