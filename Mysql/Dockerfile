FROM ubuntu:16.04

ARG MYSQL_PWD_INSTALLATION
RUN apt-get update -y \
      && apt-get -y install sudo \
      && apt-get install -y netcat

RUN sudo apt-get update -y \
    && { \
            echo "mysql-server mysql-server/root_password password $MYSQL_PWD_INSTALLATION"; \
            echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD_INSTALLATION"; \
    } | debconf-set-selections \
    && apt-get install mysql-server -y

RUN set -x \
    && sudo sh -c "echo '[mysqld]' >> /etc/mysql/my.cnf" \
    && sudo sh -c "echo 'bind-address = 0.0.0.0' >> /etc/mysql/my.cnf" \
    && sudo sh -c "echo 'default-authentication-plugin=mysql_native_password' >> /etc/mysql/my.cnf" \
    && sudo sh -c "echo 'datadir=/var/lib/mysql' >> /etc/mysql/my.cnf"

VOLUME /var/lib/mysql
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306 33060
CMD ["mysqld"]



# ENV USER Ujala
# ENV UID 1000
# ENV GID 1000
# ENV PW docker

# RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
#       chpasswd

# RUN chown -R ${USER} /home/${USER} && \
#     adduser ${USER} sudo && \
#     echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# USER ${UID}:${GID}

# WORKDIR /home/${USER}
