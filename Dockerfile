FROM ubuntu:noble

LABEL MAINTAINER "M-Fawaz Orabi <mfawwaz93@gmail.com>"

ENV S6_VERSION "v3.2.0.0"
ENV S6_ARCH "x86_64"

RUN apt-get update \
    && apt-get install -y curl gnupg sudo tzdata sqlite3 xz-utils

RUN curl -L -s https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz | tar -xJvf - -C /
RUN curl -L -s https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.xz | tar -xJvf - -C /

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C \
    && apt-get update \
    && curl -L -o insync-headless.deb https://cdn.insynchq.com/builds/linux/3.2.7.10758/insync-headless_3.2.7.10758-buster_amd64.deb \
    && apt-get install -y ./insync-headless.deb \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm /insync-headless.deb \
    && rm -rf /root/.config/Insync \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

COPY rootfs /

RUN mkdir /data \
    && useradd -m -u 911 -U user -s /bin/bash

VOLUME /data

ENTRYPOINT [ "/init" ]