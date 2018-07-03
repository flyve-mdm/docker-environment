#ARGS
ARG PHP_TAG=${PHP_TAG}
FROM php:${PHP_TAG}

ARG PHP=${PHP}
ARG GLPI_DB_NAME_TEST=${GLPI_DB_NAME_TEST}
ARG MYSQL_DB_USER_ROOT=${MYSQL_DB_USER_ROOT}
ARG MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ARG MYSQL_PASSWORD=${MYSQL_PASSWORD}
ARG HOMEPATH=${HOMEPATH}
ARG GLPI_BRANCH=${GLPI_BRANCH}
ARG GLPI_SOURCE=${GLPI_SOURCE}
ARG FLYVEMDM_BRANCH=${FLYVEMDM_BRANCH}
ARG FLYVEMDM_SOURCE=${FLYVEMDM_SOURCE}
ARG FLYVEMDM_PATH=${FLYVEMDM_PATH}
ARG FUSIONINVENTORY_BRANCH=${FUSIONINVENTORY_BRANCH}
ARG FUSIONINVENTORY_SOURCE=${FUSIONINVENTORY_SOURCE}
ARG FUSIONINVENTORY_PATH=${FUSIONINVENTORY_PATH}
ARG MOSQUITTO_BROKER_ADDRESS=${MOSQUITTO_BROKER_ADDRESS}
ARG MOSQUITTO_BROKER_INTERNAL_ADDRESS=${MOSQUITTO_BROKER_INTERNAL_ADDRESS}
ARG HOST_SERVER_MOSQUITTO_PORT=${HOST_SERVER_MOSQUITTO_PORT}
ARG HOST_SERVER_MOSQUITTO_PORT_TLS=${HOST_SERVER_MOSQUITTO_PORT_TLS}
# Environment variables
ENV PHP ${PHP}
ENV GLPI_DB_NAME_TEST ${GLPI_DB_NAME_TEST}
ENV MYSQL_DB_USER_ROOT ${MYSQL_DB_USER_ROOT}
ENV MYSQL_ROOT_PASSWORD ${MYSQL_ROOT_PASSWORD}
ENV MYSQL_PASSWORD ${MYSQL_PASSWORD}
ENV HOMEPATH ${HOMEPATH}
ENV GLPI_BRANCH ${GLPI_BRANCH}
ENV GLPI_SOURCE ${GLPI_SOURCE}
ENV CLONNING_METHOD ${CLONNING_METHOD}
ENV DEFAULT_TIME_ZONE ${DEFAULT_TIME_ZONE}
ENV FLYVEMDM_BRANCH ${FLYVEMDM_BRANCH}
ENV FLYVEMDM_SOURCE ${FLYVEMDM_SOURCE}
ENV FLYVEMDM_PATH ${FLYVEMDM_PATH}
ENV FUSIONINVENTORY_BRANCH ${FUSIONINVENTORY_BRANCH}
ENV FUSIONINVENTORY_SOURCE ${FUSIONINVENTORY_SOURCE}
ENV FUSIONINVENTORY_PATH ${FUSIONINVENTORY_PATH}
ENV MOSQUITTO_BROKER_ADDRESS ${MOSQUITTO_BROKER_ADDRESS}
ENV MOSQUITTO_BROKER_INTERNAL_ADDRESS ${MOSQUITTO_BROKER_INTERNAL_ADDRESS}
ENV HOST_SERVER_MOSQUITTO_PORT ${HOST_SERVER_MOSQUITTO_PORT}
ENV HOST_SERVER_MOSQUITTO_PORT_TLS ${HOST_SERVER_MOSQUITTO_PORT_TLS}

RUN apt-get update --fix-missing && apt-get upgrade -y && apt-get install -my wget gnupg

# here is the installation NodeJS and Bower
RUN curl -s https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs \
    && npm install -g bower

# Install iconv, mcryot, gd
RUN apt-get install -y \
        cron \
        telnet \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        git \
        mysql-client \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install memcached
RUN apt-get install -y libmemcached-dev nano curl \
  && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
  && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached opcache mbstring

# Install zip json pdo_mysql mysqli ctype fileinfo zlib simplexml xml ldap imap xmlrpc {zlib simplexml xml ldap imap xmlrpc}
RUN docker-php-ext-install zip json pdo_mysql mysqli ctype fileinfo
#Required for Flyve
RUN docker-php-ext-install sockets
RUN apt-get install -y libldb-dev libldap2-dev
RUN ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/
RUN docker-php-ext-configure ldap
## APCu
RUN yes | pecl install apcu \
    && docker-php-ext-enable apcu

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Xdebug
# here is the installation
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

#Enable Mysqli extension
RUN docker-php-ext-enable mysqli

WORKDIR $HOMEPATH
# Add www-data user to sudo group
RUN adduser www-data sudo
# Add permission to the folder
RUN chown -R www-data:www-data $HOMEPATH /var/www
# Add permission to the volume
RUN usermod -u 1000 www-data && usermod -d $HOMEPATH www-data
# Giving a shell to www-data
RUN chsh -s /bin/bash www-data
#Install/configure GLPI
RUN mkdir /opt/dev-tools
ADD ./cliinstall.sh /opt/dev-tools/
ADD ./flyvemdm-test /usr/local/bin/
RUN chmod +x /opt/dev-tools/cliinstall.sh /usr/local/bin/flyvemdm-test