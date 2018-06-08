#!/bin/bash
set -e
#
# Instalation / Configuration GLPI
#
if [ "$(ls -A $HOMEPATH)" ]; then 
    echo "The directory of site don't is empty" 
    echo "If you want cloning GLPI, remove all content in directory www and try again." 
else
    echo "Cloning GLPI from source:" $GLPI_SOURCE;
    #TODO: Pending for validing this part / Testing the viability of this
    git clone --depth=1 $GLPI_SOURCE -b $GLPI_BRANCH $HOMEPATH
    cd $HOMEPATH
    composer install --no-dev --no-interaction
    #TODO: Pending for test unit
    #if [ -e scripts/cliinstall.php ] ; then php scripts/cliinstall.php --db=glpitest --user=root --tests ; fi
    #if [ -e tools/cliinstall.php ] ; then php tools/cliinstall.php --db=glpitest --user=root --tests ; fi
fi

