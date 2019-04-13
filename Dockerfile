FROM jedisct1/phusion-baseimage-latest

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN dpkg --add-architecture i386
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y
RUN apt-get update && apt-get -y install lxde software-properties-common
RUN apt-get -y install --install-recommends winehq-stable
RUN sudo add-apt-repository ppa:x2go/stable -y
RUN apt-get update && apt-get -y install x2goserver x2goserver-xsession

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV WINEPREFIX /root/prefix32
ENV DISPLAY :0

WORKDIR /root/

# Enabling SSH
RUN rm -f /etc/service/sshd/down
EXPOSE 22

CMD ["/usr/bin/supervisord"]
