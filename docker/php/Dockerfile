#ARGS
ARG PHP_TAG=${PHP_TAG}

FROM php:${PHP_TAG}

ARG GLPI_BRANCH=${GLPI_BRANCH}
ARG GLPI_SOURCE=${GLPI_SOURCE}
# Environment variables
ENV HOMEPATH /webapp
ENV GLPI_BRANCH ${GLPI_BRANCH}
ENV GLPI_SOURCE ${GLPI_SOURCE}
ENV CLONNING_METHOD ${CLONNING_METHOD}

RUN apt-get update --fix-missing && apt-get install -my wget gnupg

# here is the installation NodeJS and Bower
RUN curl -s https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs \
    && npm install -g bower

# Install iconv, mcryot, gd
RUN apt-get install -y \
        cron \
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
ADD ./cliinstall.sh /opt/
RUN chmod +x /opt/cliinstall.sh