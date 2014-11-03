# sshd
#
# VERSION               0.0.1

FROM     gendosu/ubuntu-base:12.04

# make sure the package repository is up to date
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN sed -i".back" -e 's/\/\/archive.ubuntu.com/\/\/ftp.jaist.ac.jp\/pub\/Linux/g' /etc/apt/sources.list

RUN apt-get update \
&&  apt-get install -y \
    openssh-server \
    supervisor \
    vim \
    build-essential \
    git \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
&&  mkdir -p /var/run/sshd

ADD supervisord/sshd.conf /etc/supervisor/conf.d/sshd.conf

RUN echo 'root:root' |chpasswd

EXPOSE 22

CMD ["/usr/bin/supervisord"]

