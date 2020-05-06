FROM ubuntu:16.04

# ENV USER Ujala
# ENV UID 1000
# ENV GID 1000
# ENV PW docker

RUN apt-get -y update && apt-get -y install apache2 \
    php \
    php-mysql \
    libapache2-mod-php \ 
    wget \
    && a2enmod php7.0 \
    && apt-get -y install sudo

WORKDIR /var/www/html

RUN set -x \
    && wget https://wordpress.org/wordpress-5.1.1.tar.gz \
    && tar -xzf wordpress-5.1.1.tar.gz \
    && cp -r wordpress/* /var/www/html/ \
    && rm -f index.html \
    && rm -rf wordpress \
    && rm -rf wordpress-5.1.1.tar.gz \
    && mv wp-config-sample.php wp-config.php \
    && sed -i "s/index.php//" /etc/apache2/mods-available/dir.conf \
    && sed -i "s/index.php//" /etc/apache2/mods-enabled/dir.conf \
    && sed -i "s/DirectoryIndex/DirectoryIndex index.php/" /etc/apache2/mods-available/dir.conf \
    && sed -i "s/DirectoryIndex/DirectoryIndex index.php/" /etc/apache2/mods-enabled/dir.conf 

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]

# RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
#       chpasswd

# RUN chown -R ${USER} /home/${USER} && \
#     adduser ${USER} sudo && \
#     echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# USER ${UID}:${GID}

# WORKDIR /home/${USER}