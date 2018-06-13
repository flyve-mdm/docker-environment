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
    #TODO: Pending for validing this part / Testing the viability of this
    git clone --progress --depth=1 $GLPI_SOURCE -b $GLPI_BRANCH $HOMEPATH
    # Add permission to the folder
    chown -R www-data:www-data $HOMEPATH /var/www
    echo "Installing packages...";
    su - www-data -c 'composer install --no-dev --no-interaction'
fi
#Configuring cron for GLPI
echo "Configuring cron for GLPI..."
echo "*/2 * * * * www-data /usr/local/bin/php $HOMEPATH/front/cron.php &>/dev/null" >> /etc/cron.d/glpi
php-fpm -F