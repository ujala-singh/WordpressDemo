FROM ubuntu:16.04

# ARG DATABASE_ROOT_PASS 

# RUN apt-get update \
#  && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
#  && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf \
#  && mkdir /var/run/mysqld \
#  && chown -R mysql:mysql /var/run/mysqld

# RUN service mysql start \
#     && mysqladmin -u root password "$DATABASE_ROOT_PASS" \
#     && mysql -u root -p"$DATABASE_ROOT_PASS" -e "Alter user 'root'@'localhost' identified by '${DATABASE_ROOT_PASS}'" 

ARG MYSQL_PWD_INSTALLATION
RUN apt-get update -y
RUN { \
            echo "mysql-server mysql-server/root_password password $MYSQL_PWD_INSTALLATION"; \
            echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD_INSTALLATION"; \
    } | debconf-set-selections \
    && apt-get install mysql-server -y

RUN set -x \
    && echo "[mysqld]" >> /etc/mysql/my.cnf \
    && echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf \
    && echo "default-authentication-plugin=mysql_native_password" >> /etc/mysql/my.cnf

RUN service mysql start

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD ["mysqld_safe"]
