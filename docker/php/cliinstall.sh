#!/bin/bash
set -x
#
# Instalation / Configuration GLPI
#
echo "Cloning GLPI from source:" $GLPI_SOURCE;
# git clone --depth=1 $GLPI_SOURCE -b $GLPI_TAG $HOMEPATH
# composer install --no-dev --no-interaction
cd $HOMEPATH
#TODO: Pending for validing this part / Testing the viability of this
# curl -O -L "https://github.com/glpi-project/glpi/releases/download/$GLPI_TAG/glpi-$GLPI_TAG.tgz" && \
#     tar -xzf "glpi-$GLPI_TAG.tgz" --strip 1 && \
#     rm "glpi-$GLPI_TAG.tgz"
git clone --depth=1 $GLPI_SOURCE -b $GLPI_TAG $HOMEPATH
#if [ -e scripts/cliinstall.php ] ; then php scripts/cliinstall.php --db=glpitest --user=root --tests ; fi
#if [ -e tools/cliinstall.php ] ; then php tools/cliinstall.php --db=glpitest --user=root --tests ; fi