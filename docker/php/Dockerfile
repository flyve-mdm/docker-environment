#ARGS
ARG PHP_TAG=${PHP_TAG}

FROM php:${PHP_TAG}

ARG GLPI_TAG=${GLPI_TAG}
ARG GLPI_SOURCE=${GLPI_SOURCE}
# Environment variables
ENV HOMEPATH /webapp\ 
    GLPI_TAG ${GLPI_TAG} \
    GLPI_SOURCE ${GLPI_SOURCE}

RUN apt-get update && apt-get install -my wget gnupg \
    # here is the installation NodeJS and Bower
    curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    apt-get install -y nodejs \
    && npm install -g bower \
    # Install iconv, mcryot, gd
    apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        git \
        mysql-client \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    # Install memcached
    apt-get install -y libmemcached-dev nano \
    && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached opcache mbstring \
    # Install curl
    apt-get install -y libcurl4-openssl-dev \
    && docker-php-ext-install curl \
    # Install zip json pdo_mysql mysqli ctype fileinfo zlib simplexml xml ldap imap xmlrpc {zlib simplexml xml ldap imap xmlrpc}
    docker-php-ext-install zip json pdo_mysql mysqli ctype fileinfo \
    #Required for Flyve
    docker-php-ext-install sockets \
    apt-get install -y libldb-dev libldap2-dev \
    ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/ \
    docker-php-ext-configure ldap \
    ## APCu
    yes | pecl install apcu \
    && docker-php-ext-enable apcu \
    # Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    # Xdebug
    # here is the installation
    pecl install xdebug \
    docker-php-ext-enable xdebug \
    #Enable Mysqli extension
    docker-php-ext-enable mysqli


WORKDIR $HOMEPATH
    # Add www-data user to sudo group
RUN adduser www-data sudo \
    # Add permission to the folder
    chown -R www-data:www-data $HOMEPATH /var/www \
    # Add permission to the volume
    usermod -u 1000 www-data \
    # Giving a shell to www-data
    chsh -s /bin/bash www-data \
    git config --global https.postBuffer 524288000 \
    git repack -a -f -d --window=250 --depth=250 \

#Install/configure GLPI
ADD ./cliinstall.sh /opt/
RUN chmod +x /opt/cliinstall.sh \
    /opt/cliinstall.sh

