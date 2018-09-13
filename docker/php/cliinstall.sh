#!/bin/bash
#
# Instalation / Configuration GLPI
#

su - www-data

if [ "$(ls -A $GLPIPATH)" ]; then
    echo "The directory of site don't is empty"
    echo "If you want cloning GLPI, remove all content in directory www and try again."
else
    echo "Cloning GLPI from source:" $GLPI_SOURCE;
    echo "Checkout in the Branch:" $GLPI_BRANCH;
    git clone --quiet -v --depth 1 $GLPI_SOURCE -b $GLPI_BRANCH $GLPIPATH
    cd $GLPIPATH
    echo "Installing GLPI packages...";
    composer install --no-dev --no-interaction
    PHPSCRIPT='scripts/cliinstall.php';
    if [ -e tools/cliinstall.php ] ; then
       PHPSCRIPT='tools/cliinstall.php';
    fi
    php $PHPSCRIPT --host=dockerdb --user=root --pass=$MYSQL_ROOT_PASSWORD --db=$GLPI_DB_NAME --force;

    #Configuring cron for GLPI
    echo "Configuring cron for GLPI..."
    echo "*/2 * * * * www-data /usr/local/bin/php $GLPIPATH/front/cron.php &>/dev/null" >> /etc/cron.d/glpi

    # update GLPI config
    echo "Updating GLPI config..."
    mysql -h dockerdb -u root -p$MYSQL_ROOT_PASSWORD -e "UPDATE glpi_configs SET value='http://$HOST_SERVER_NAME/' WHERE name='url_base'" $GLPI_DB_NAME
    mysql -h dockerdb -u root -p$MYSQL_ROOT_PASSWORD -e "UPDATE glpi_configs SET value='http://$HOST_SERVER_NAME/apirest.php/' WHERE name='url_base_api'" $GLPI_DB_NAME
    mysql -h dockerdb -u root -p$MYSQL_ROOT_PASSWORD -e "UPDATE glpi_configs SET value=1 WHERE name IN ('use_notifications', 'notifications_mailing', 'enable_api', 'enable_api_login_credentials')" $GLPI_DB_NAME
    mysql -h dockerdb -u root -p$MYSQL_ROOT_PASSWORD -e "INSERT INTO glpi_apiclients (is_recursive, name, is_active, app_token) VALUES (1, 'full access from everywhere', 1, '')" $GLPI_DB_NAME
fi

cd $GLPIPATH

# Instalation / Configuration of Fusioninventory
if [ -d plugins$FUSIONINVENTORY_PATH ] && [ "$(ls -A plugins$FUSIONINVENTORY_PATH)" ]; then
    echo "The directory's Flyvemdm exist"
    echo "If you want reinstall, remove the directory and try again."
else
    echo "Cloning Fusioninventory from source:" $FUSIONINVENTORY_SOURCE;
    echo "Checkout in the Branch:" $FUSIONINVENTORY_BRANCH;
    git clone --quiet -v --depth 1 $FUSIONINVENTORY_SOURCE -b $FUSIONINVENTORY_BRANCH plugins$FUSIONINVENTORY_PATH
    php plugins$FUSIONINVENTORY_PATH/scripts/cli_install.php --as-user glpi
fi

# Instalation / Configuration Flyvemdm
if [ -d plugins$FLYVEMDM_PATH ] && [ "$(ls -A plugins$FLYVEMDM_PATH)" ]; then
    echo "The directory's Flyvemdm exist"
    echo "If you want reinstall, remove the directory and try again."
else
    echo "Cloning Flyvemdm from source:" $FLYVEMDM_SOURCE;
    echo "Checkout in the Branch:" $FLYVEMDM_BRANCH;
    git clone --quiet $FLYVEMDM_SOURCE -b $FLYVEMDM_BRANCH plugins$FLYVEMDM_PATH
    echo "Installing packages...";
    cd plugins$FLYVEMDM_PATH
    composer install
    php tools/cli_install.php --enable-api --mqtt-internal-address dockerMosquitto \
        --mqtt-port $HOST_SERVER_MOSQUITTO_PORT --mqtt-port-tls $HOST_SERVER_MOSQUITTO_PORT_TLS
fi

# Add permission to the folder
chmod -R 777 $GLPIPATH/files
chown -R www-data:www-data $GLPIPATH
echo "FlyveMDM is ready to use"
php-fpm -F