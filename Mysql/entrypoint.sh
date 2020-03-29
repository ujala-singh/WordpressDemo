#!/bin/sh
set -e
/etc/init.d/mysql start
if [ "$MYSQL_DATABASE" != "" ]; then
        echo "Creating database: $MYSQL_DATABASE"
        mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
        if [ "$MYSQL_USER" != "" ]; then
            echo "Creating user: $MYSQL_USER"
            mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER'$MYSQL_USER' IDENTIFIED BY '$MYSQL_PASSWORD';"
            mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER';"
            mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
        fi
fi
tail -f /dev/null
# sleep 2000000 &
# CHILD=$!
# wait "$CHILD"