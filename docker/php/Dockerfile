#ARGS
ARG PHP_TAG=${PHP_TAG}
FROM php:${PHP_TAG}

ARG GLPI_DB_NAME_TEST=${GLPI_DB_NAME_TEST}
ARG GLPI_DB_NAME_UPGRADE_TEST=${GLPI_DB_NAME_UPGRADE_TEST}
ARG MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ARG GLPI_DB_NAME=${GLPI_DB_NAME}
ARG GLPIPATH=${GLPIPATH}
ARG GLPI_BRANCH=${GLPI_BRANCH}
ARG GLPI_SOURCE=${GLPI_SOURCE}
ARG FLYVEMDM_BRANCH=${FLYVEMDM_BRANCH}
ARG FLYVEMDM_SOURCE=${FLYVEMDM_SOURCE}
ARG FLYVEMDM_PATH=${FLYVEMDM_PATH}
ARG FUSIONINVENTORY_BRANCH=${FUSIONINVENTORY_BRANCH}
ARG FUSIONINVENTORY_SOURCE=${FUSIONINVENTORY_SOURCE}
ARG FUSIONINVENTORY_PATH=${FUSIONINVENTORY_PATH}
ARG HOST_SERVER_MOSQUITTO_PORT=${HOST_SERVER_MOSQUITTO_PORT}
ARG HOST_SERVER_MOSQUITTO_PORT_TLS=${HOST_SERVER_MOSQUITTO_PORT_TLS}
ARG HOST_SERVER_NAME=${HOST_SERVER_NAME}

# Environment variables
ENV GLPI_DB_NAME_TEST ${GLPI_DB_NAME_TEST}
ENV GLPI_DB_NAME_UPGRADE_TEST ${GLPI_DB_NAME_UPGRADE_TEST}
ENV MYSQL_ROOT_PASSWORD ${MYSQL_ROOT_PASSWORD}
ENV GLPI_DB_NAME ${GLPI_DB_NAME}
ENV GLPIPATH ${GLPIPATH}
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
ENV HOST_SERVER_MOSQUITTO_PORT ${HOST_SERVER_MOSQUITTO_PORT}
ENV HOST_SERVER_MOSQUITTO_PORT_TLS ${HOST_SERVER_MOSQUITTO_PORT_TLS}
ENV HOST_SERVER_NAME ${HOST_SERVER_NAME}

RUN apt-get update --fix-missing && apt-get upgrade -y && apt-get install -my wget gnupg

# here is the installation NodeJS and Bower
#RUN curl -s https://deb.nodesource.com/setup_6.x | bash -
#RUN apt-get install -y nodejs \
#    && npm install -g bower

# Install iconv, mcrypt, gd
RUN apt-get install -y cron libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
        git mysql-client libldb-dev libldap2-dev libbz2-dev unzip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd iconv mcrypt

# Install memcached
RUN apt-get install -y libmemcached-dev nano curl dos2unix \
  && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
  && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached opcache mbstring

# Install php extensions
RUN docker-php-ext-install zip json pdo_mysql mysqli ctype fileinfo sockets bz2
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

WORKDIR $GLPIPATH
# Add www-data user to sudo group
RUN adduser www-data sudo
# Add permission to the folder
RUN chown -R www-data:www-data $GLPIPATH /var/www
# Add permission to the volume
RUN usermod -u 1000 www-data && usermod -d $GLPIPATH www-data
# Giving a shell to www-data
RUN chsh -s /bin/bash www-data
#Install/configure GLPI
RUN mkdir /opt/dev-tools
ADD ./cliinstall.sh /opt/dev-tools/
ADD ./flyvemdm-test /usr/local/bin/
RUN chmod +x /opt/dev-tools/cliinstall.sh /usr/local/bin/flyvemdm-test
RUN dos2unix /opt/dev-tools/cliinstall.sh /usr/local/bin/flyvemdm-test