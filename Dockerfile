#
# Copyright (c) 2001-2018 Primeton Technologies, Ltd.
# All rights reserved.
#
# author: ZhongWen Li (mailto:lizw@primeton.com)
#

FROM centos:7

LABEL maintainer="lizw@primeton.com" \
    provider="Primeton Technologies, Ltd."

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

ENV JAVA_VERSION="9.0.1"

ENV JAVA_HOME="/usr/local/jdk${JAVA_VERSION}"

ENV PATH="${PATH}:${JAVA_HOME}/bin"

# Do not use alias cp
RUN \cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum update -y \
    && yum install -y zip unzip tar curl wget \
    && echo "alias l='ls -al'" >> /root/.bashrc

# ADD resources/jdk*.tar.gz /usr/local/
RUN wget --tries=3 \
        --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz \
        -O /tmp/jdk.tar.gz \
    && tar -zxf /tmp/jdk.tar.gz -C /usr/local/ \
    && \rm -f /tmp/jdk.tar.gz ${JAVA_HOME}/src.zip ${JAVA_HOME}/javafx-src.zip

# Find avaliable downloads
# curl -s http://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html | awk "/downloads\['/ && ! /demos/ && /\['files'\]\['jdk/"
