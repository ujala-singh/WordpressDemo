#!/bin/sh
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "bind-address = 127.0.0.1" >> /etc/mysql/my.cnf 
echo "default-authentication-plugin=mysql_native_password" >> /etc/mysql/my.cnf
/etc/init.d/mysql start
ps aux
echo $MYSQL_PWD
mysql -h 127.0.0.1 -P 3306 -u root -p$MYSQL_PWD -e "create database wpdb;"
mysql -h 127.0.0.1 -P 3306 -u root -p$MYSQL_PWD -e "create user 'jolly'@'localhost' identified by 'Ujalasingh12@';"
mysql -h 127.0.0.1 -P 3306 -u root -p$MYSQL_PWD -e "GRANT ALL PRIVILEGES ON *.* TO 'jolly'@'localhost';"
mysql -h 127.0.0.1 -P 3306 -u root -p$MYSQL_PWD -e "flush privileges;"

sed -i 's/database_name_here/wpdb/' /var/www/html/wp-config.php
sed -i 's/username_here/jolly/' /var/www/html/wp-config.php
sed -i 's/password_here/Ujalasingh12@/' /var/www/html/wp-config.php

sed -i "s/index.php//" /etc/apache2/mods-available/dir.conf
sed -i "s/index.php//" /etc/apache2/mods-enabled/dir.conf
sed -i "s/DirectoryIndex/DirectoryIndex index.php/" /etc/apache2/mods-available/dir.conf
sed -i "s/DirectoryIndex/DirectoryIndex index.php/" /etc/apache2/mods-enabled/dir.conf

/usr/sbin/apachectl -D FOREGROUND
# /etc/init.d/apache2 start -D FOREGROUND
# sleep 2000000 &
# CHILD=$!
# wait "$CHILD"