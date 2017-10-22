FROM ubuntu:latest
MAINTAINER dekmabot@gmail.com

RUN apt-get update
RUN apt-get install -y --no-install-recommends openssh-server supervisor curl
RUN apt-get install -y --no-install-recommends mysql-client nginx composer nano cron libfontconfig1 libxrender1
RUN apt-get install -y --no-install-recommends php php-fpm php-curl php-gd php-imap php-imagick php7.0-mbstring php7.0-zip php7.0-dom php-mysql
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN apt-get autoremove

RUN mkdir -p /var/run/sshd /var/log/supervisor
 
RUN usermod -u 1000 www-data

ADD laravel.ini /usr/local/etc/php/conf.d
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD nginx-host.conf /etc/nginx/sites-enabled/

WORKDIR /var/www/laravel
 
EXPOSE 22 80 443
 
CMD ["/usr/bin/supervisord"]
