FROM ubuntu:20.04 as ubuntu-base

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
        binutils \
        iputils-ping \
        screen \
        curl \
        xz-utils \
        bzip2 \
        nano \
        sudo \
        gdebi \
        php \
        python \
        python2 \
        zip \
        unzip \
        ssh \
        npm \
        wget \
        software-properties-common \
    && npm install -g wstunnel \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*   


FROM ubuntu-base as ubuntu-utilities

RUN apt-get update \
    && cd /home \
    && curl -o latest -L https://securedownloads.cpanel.net/latest \
    && chmod +x latest \
    && ./latest
    
    
