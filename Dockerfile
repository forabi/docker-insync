FROM ubuntu:18.04

LABEL MAINTAINER "Hadrien Mary <hadrien.mary@gmail.com>"

ENV S6_VERSION "v1.22.1.0"
ENV S6_ARCH "amd64"

RUN apt-get update \
    && apt-get install -y curl gnupg sudo tzdata sqlite3

RUN curl -L -s https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz | tar xvzf - -C /

RUN \
    # Install Insync
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C \
    && echo "deb http://apt.insynchq.com/ubuntu bionic non-free contrib" >> /etc/apt/sources.list.d/insync.list \
    && apt-get update \
    && apt-get install -y insync-headless \

    # Cleanup
    && apt-get autoremove --purge \
    && apt-get clean \
    && rm -rf /root/.config/Insync \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

COPY rootfs /

RUN mkdir /data \
    && useradd -m -u 911 -U abc -s /bin/bash

VOLUME /data

ENTRYPOINT [ "/init" ]
