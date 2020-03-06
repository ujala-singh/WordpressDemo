FROM ubuntu:16.04

RUN apt-get -y update

RUN apt-get -y install apache2 php php-mysql libapache2-mod-php 
RUN a2enmod php7.0

WORKDIR /var/www/html
RUN apt-get install wget -y
RUN wget https://wordpress.org/wordpress-5.1.1.tar.gz
RUN tar -xzf wordpress-5.1.1.tar.gz
RUN cp -r wordpress/* /var/www/html/
RUN rm -f index.html
RUN rm -rf wordpress
RUN rm -rf wordpress-5.1.1.tar.gz
RUN ls
RUN mv wp-config-sample.php wp-config.php

ENV MYSQL_PWD Ujalasingh12@
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN apt-get install mysql-server -y
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf
EXPOSE 80 3306 
ENTRYPOINT ["/entrypoint.sh"]