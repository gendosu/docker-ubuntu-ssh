# sshd
#
# VERSION               0.0.1

FROM     ubuntu:12.04
MAINTAINER Gen Takahashi "gendosu@gmail.com"

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y openssh-server supervisor
RUN mkdir -p /var/run/sshd 
RUN echo 'root:root' |chpasswd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22

CMD ["/usr/bin/supervisord"]

