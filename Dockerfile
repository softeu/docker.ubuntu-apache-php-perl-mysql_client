FROM ubuntu:14.04

MAINTAINER Jindrich Vimr <jvimr@softeu.com>

RUN echo "1.565.1" > .lts-version-number

RUN apt-get update && apt-get install -y wget git curl zip vim
RUN apt-get update && apt-get install -y apache2 php5 perl libapache2-mod-perl2 php5-mysql libdbd-mysql-perl libdatetime-format-builder-perl libemail-abstract-perl libemail-send-perl libemail-simple-perl libemail-mime-perl libtemplate-perl libmath-random-isaac-perl libgd-text-perl libgd-graph-perl libxml-twig-perl libchart-perl libnet-ldapapi-perl libtemplate-plugin-gd-perl  libfile-slurp-perl libhtml-scrubber-perl libhtml-formattext-withlinks-perl libjson-rpc-perl libjson-xs-perl libnet-ldap-perl libauthen-radius-perl libencode-detect-perl libfile-mimeinfo-perl libio-stringy-perl libdaemon-generic-perl


RUN apt-get update && apt-get install -y php5-intl imagemagick


RUN usermod -U www-data && chsh -s /bin/bash www-data

RUN echo 'ServerName ${SERVER_NAME}' >> /etc/apache2/conf-enabled/servername.conf

COPY enable-var-www-html-htaccess.conf /etc/apache2/conf-enabled/
COPY run_apache.sh /var/www/
RUN a2enmod rewrite cgi perl headers



volume "/var/log"






#USER www-data

#VOLUME ["/var/www/html", "/var/log/apache2" ]
ENV SERVER_NAME docker-apache-php


# for main web interface:
EXPOSE 80

WORKDIR /var/www/html


CMD ["/var/www/run_apache.sh"]
