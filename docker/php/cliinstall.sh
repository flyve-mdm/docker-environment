#!/bin/bash
#
# Instalation / Configuration GLPI
#
if [ "$(ls -A $HOMEPATH)" ]; then
    echo "The directory of site don't is empty"
    echo "If you want cloning GLPI, remove all content in directory www and try again."
    su - www-data -c 'composer install --no-dev --no-interaction'
else
    echo "Cloning GLPI from source:" $GLPI_SOURCE;
    echo "Checkout in the Branch:" $GLPI_BRANCH;
    git clone --progress --depth=1 $GLPI_SOURCE -b $GLPI_BRANCH $HOMEPATH
    echo "Installing packages...";
    su - www-data -c 'composer install --no-dev --no-interaction'
fi
#Configuring cron for GLPI
echo "Configuring cron for GLPI..."
echo "*/2 * * * * www-data /usr/local/bin/php $HOMEPATH/front/cron.php &>/dev/null" >> /etc/cron.d/glpi
# Instalation / Configuration Flyvemdm and Fusioninventory
#
if [ -d $HOMEPATH$GLPI_PLUGINS_DIRECTORY$FLYVEMDM_PATH ] && [ "$(ls -A $HOMEPATH$GLPI_PLUGINS_DIRECTORY$FLYVEMDM_PATH)" ]; then
    echo "The directory's Flyvemdm exist"
    echo "If you want reinstall, remove the directory $FLYVEMDM_PATH and $FUSIONINVENTORY_PATH, and try again."
    cd $HOMEPATH$GLPI_PLUGINS_DIRECTORY$FLYVEMDM_PATH
    su - www-data -c 'composer install --no-dev'
else
    echo "Cloning Fusioninventory from source:" $FUSIONINVENTORY_SOURCE;
    echo "Checkout in the Branch:" $FUSIONINVENTORY_BRANCH;
    git clone --progress --depth=1 $FUSIONINVENTORY_SOURCE -b $FUSIONINVENTORY_BRANCH $HOMEPATH$GLPI_PLUGINS_DIRECTORY$FUSIONINVENTORY_PATH
    echo "Cloning Flyvemdm from source:" $FLYVEMDM_SOURCE;
    echo "Checkout in the Branch:" $FLYVEMDM_BRANCH;
    git clone --progress --depth=1 $FLYVEMDM_SOURCE -b $FLYVEMDM_BRANCH $HOMEPATH$GLPI_PLUGINS_DIRECTORY$FLYVEMDM_PATH
    cd $HOMEPATH$GLPI_PLUGINS_DIRECTORY$FLYVEMDM_PATH
    echo "Installing packages...";
    su - www-data -c 'composer install --no-dev'
fi
# Add permission to the folder
chown -R www-data:www-data $HOMEPATH /var/www
php-fpm -F