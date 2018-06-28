#!/bin/sh

mysql -u $MYSQL_DB_USER_ROOT -p$MYSQL_ROOT_PASSWORD -e "DROP DATABASE IF EXISTS \`$GLPI_DB_NAME_TEST\`"
if [ -f $HOMEPATH/scripts/cliinstall.php ]; then
	$PHP $HOMEPATH/scripts/cliinstall.php --db=$GLPI_DB_NAME_TEST --user=$MYSQL_DB_USER_ROOT --pass=$MYSQL_ROOT_PASSWORD --tests --force
else
	$PHP $HOMEPATH/tools/cliinstall.php --db=$GLPI_DB_NAME_TEST --user=$MYSQL_DB_USER_ROOT --pass=$MYSQL_ROOT_PASSWORD --tests --force
fi

echo "=== Install tests ==="
$PHP $HOMEPATH/plugins/flyvemdm/vendor/bin/atoum --debug -bf $HOMEPATH/plugins/flyvemdm/tests/bootstrap.php -no-cc -d $HOMEPATH/plugins/flyvemdm/tests/suite-install

echo "=== Unit tests ==="
$PHP $HOMEPATH/plugins/flyvemdm/vendor/bin/atoum --debug -bf $HOMEPATH/plugins/flyvemdm/tests/bootstrap.php -no-cc -d $HOMEPATH/plugins/flyvemdm/tests/suite-unit

echo "=== Integration tests ==="
$PHP $HOMEPATH/plugins/flyvemdm/vendor/bin/atoum --debug -bf $HOMEPATH/plugins/flyvemdm/tests/bootstrap.php -no-cc -d $HOMEPATH/plugins/flyvemdm/tests/suite-integration

#echo "=== Functional tests ==="

echo "=== Uninstall tests ==="
$PHP $HOMEPATH/plugins/flyvemdm/vendor/bin/atoum --debug -bf $HOMEPATH/plugins/flyvemdm/tests/bootstrap.php -no-cc -d $HOMEPATH/plugins/flyvemdm/tests/suite-uninstall
