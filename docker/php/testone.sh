#!/bin/sh

echo "=== Unit tests ==="
if [ -f $1 ]; then
    RESOURCE_TYPE="-f"
elif [ -d $1 ]; then
    RESOURCE_TYPE="-d"
fi
$PHP $HOMEPATH/plugins/flyvemdm/vendor/bin/atoum --debug -bf $HOMEPATH/plugins/flyvemdm/tests/bootstrap.php -no-cc $RESOURCE_TYPE $1
