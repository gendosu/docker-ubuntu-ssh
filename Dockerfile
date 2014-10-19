# sshd
#
# VERSION               0.0.1

FROM     ubuntu:14.04.1
MAINTAINER Gen Takahashi "gendosu@gmail.com"

# make sure the package repository is up to date
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
#RUN sed -i".back" -e 's/\/\/archive.ubuntu.com/\/\/ftp.jaist.ac.jp\/pub\/Linux/g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y openssh-server supervisor vim build-essential
RUN mkdir -p /var/run/sshd 
RUN sed -ibak -e "s/^PermitRootLogin.*$/PermitRootLogin yes/" /etc/ssh/sshd_config
ADD supervisord/sshd.conf /etc/supervisor/conf.d/sshd.conf
RUN echo 'root:root' |chpasswd

EXPOSE 22

CMD ["/usr/bin/supervisord"]

