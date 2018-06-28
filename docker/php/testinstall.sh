#!/bin/sh

mysql -u $MYSQL_DB_USER_ROOT -p$MYSQL_ROOT_PASSWORD -e "DROP DATABASE IF EXISTS \`$GLPI_DB_NAME_TEST\`"
$PHP $HOMEPATH/scripts/cliinstall.php --db=$GLPI_DB_NAME_TEST --user=$MYSQL_DB_USER_ROOT --pass=$MYSQL_ROOT_PASSWORD --tests --force

echo "=== Install tests ==="
$PHP $HOMEPATH/plugins/flyvemdm/vendor/bin/atoum --debug -bf $HOMEPATH/plugins/flyvemdm/tests/bootstrap.php -no-cc -d $HOMEPATH/plugins/flyvemdm/tests/suite-install

