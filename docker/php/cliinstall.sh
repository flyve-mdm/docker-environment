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
    echo "Installing packages";
    su - www-data -c 'composer install --no-dev --no-interaction'
    #TODO: Pending for test unit
    #if [ -e scripts/cliinstall.php ] ; then php scripts/cliinstall.php --db=glpitest --user=root --tests ; fi
    #if [ -e tools/cliinstall.php ] ; then php tools/cliinstall.php --db=glpitest --user=root --tests ; fi
fi
php-fpm -F