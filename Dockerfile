# sshd
#
# VERSION               0.0.1

FROM     gendosu/ubuntu-base:14.04.1

MAINTAINER Gen Takahashi "gendosu@gmail.com"

RUN apt-get update \
&&  apt-get install -y \
    openssh-server \
    supervisor \
    vim \
    build-essential \
    git \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
&&  mkdir -p /var/run/sshd \
&&  sed -ibak -e "s/^PermitRootLogin.*$/PermitRootLogin yes/" /etc/ssh/sshd_config

ADD supervisord/sshd.conf /etc/supervisor/conf.d/sshd.conf

RUN echo 'root:root' |chpasswd

EXPOSE 22

CMD ["/usr/bin/supervisord"]

