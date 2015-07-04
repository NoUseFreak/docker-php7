FROM ubuntu-upstart:14.04

MAINTAINER Dries De Peuter <dries@nousefreak.be>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C \
 	&& echo "deb http://ppa.launchpad.net/nginx/development/ubuntu trusty main" > /etc/apt/sources.list.d/nginx-development.list \
 	&& echo "deb http://repos.zend.com/zend-server/early-access/php7/repos ubuntu/" >> /etc/apt/sources.list.d/php7-nightly.list

RUN apt-get update \
	&& apt-get install -y --force-yes \
	    php7-nightly \
	    nginx \
	    git \
	    build-essential \
	    automake \
	&& apt-get clean

ENV PATH $PATH:/usr/local/php7/bin

RUN cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf \
	&& mkdir /usr/local/php7/etc/conf.d \
	&& echo "date.timezone = Europe/Brussels" >> /usr/local/php7/etc/conf.d/timezone.ini

COPY conf/init.nginx.conf /etc/init/nginx.conf
COPY conf/init.php-fpm.conf /etc/init/php-fpm.conf
COPY conf/nginx.conf /etc/nginx/sites-enabled/default
COPY conf/php.pool.conf /usr/local/php7/etc/php-fpm.d/www.conf

WORKDIR /var/www/html

EXPOSE 80
