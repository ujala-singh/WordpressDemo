FROM ubuntu:16.04

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

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306 33060
CMD ["mysqld"]
