FROM ubuntu:18.04 as ubuntu-base

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
        binutils \
        iputils-ping \
        xz-utils \
        bzip2 \
        nano \
        sudo \
        gdebi \
        python-gtk2 \
        supervisor \
        xvfb x11vnc novnc websockify \
        zip \
        unzip \
        ssh \
        npm \
        wget \
        software-properties-common \
        task-xfce-desktop \
        xrdp tigervnc-standalone-server \
    && npm install -g wstunnel \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*   



===========================
# Utilities
#============================
FROM ubuntu-base as ubuntu-utilities

RUN apt-get update \
    && apt install unzip \
    && dpkg --configure -a \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -qqy --no-install-recommends ./google-chrome-stable_current_amd64.deb \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
    
    
RUN wget -c https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.6/fahclient_7.6.21_amd64.deb \
    && wget -c https://download.foldingathome.org/releases/public/release/fahcontrol/debian-stable-64bit/v7.6/fahcontrol_7.6.21-1_all.deb \
    
RUN ar vx fahclient_7.6.21_amd64.deb
RUN tar -xvf control.tar.xz
RUN tar -xvf data.tar.xz
    
RUN dpkg -i --force-depends fahclient_7.6.21_amd64.deb
RUN dpkg -i --force-depends fahcontrol_7.6.21-1_all.deb


# COPY conf.d/* /etc/supervisor/conf.d/


#============================
# GUI
#============================
FROM ubuntu-utilities as ubuntu-ui


# RUN apt-get update -qqy \
#     && apt-get -qqy install \
#         xserver-xorg xserver-xorg-video-fbdev xinit pciutils xinput xfonts-100dpi xfonts-75dpi xfonts-scalable kde-plasma-desktop
RUN apt --fix-broken install -y
RUN systemctl set-default graphical.target
