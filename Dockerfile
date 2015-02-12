# sshd
#
# VERSION               0.0.1

FROM     ubuntu:14.04.1
MAINTAINER Gen Takahashi "gendosu@gmail.com"

RUN apt-get update

RUN apt-get install -y openssh-server supervisor vim build-essential git
RUN mkdir -p /var/run/sshd 
RUN sed -ibak -e "s/^PermitRootLogin.*$/PermitRootLogin yes/" /etc/ssh/sshd_config
ADD supervisord/sshd.conf /etc/supervisor/conf.d/sshd.conf
RUN echo 'root:root' |chpasswd

EXPOSE 22

CMD ["/usr/bin/supervisord"]

