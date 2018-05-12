FROM ubuntu:latest
MAINTAINER dekmabot@gmail.com

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends openssh-server supervisor curl
RUN apt-get install -y --no-install-recommends nginx composer nano cron
RUN apt-get autoremove

RUN mkdir -p /var/run/sshd /var/log/supervisor
 
RUN usermod -u 1000 www-data

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD nginx-host.conf /etc/nginx/sites-enabled/default
ADD index.html /var/www/static-site/index.html

WORKDIR /var/www/static-site
 
EXPOSE 22 80
 
CMD ["/usr/bin/supervisord"]
