FROM ubuntu:16.04

MAINTAINER Monerador <moneradoor@gmail.com>
LABEL maintainer="Monerador <moneradoor@gmail.com>"

ARG USER_ID
ARG GROUP_ID

ENV HOME /dero

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} dero \
        && useradd -u ${USER_ID} -g dero -s /bin/bash -m -d /dero dero

RUN echo "fs.file-max = 65535" > /etc/sysctl.conf

RUN set -x \
        && apt-get update && apt-get install -y --no-install-recommends \
                ca-certificates \
                wget \
                unzip \
                libboost-all-dev qtbase5-dev libssl-dev cmake git libboost1.58-all-dev build-essential g++ net-tools \
                miniupnpc libunbound-dev graphviz doxygen libunwind8-dev pkg-config libssl-dev libcurl4-openssl-dev libgtest-dev libreadline-dev libzmq3-dev libsodium-dev libpcsclite-dev


# Install Binaries
RUN wget "https://github.com/deroproject/download/blob/master/dero_linux_amd64.tar.gz?raw=true" \
&& tar -xvzf dero_linux_amd64.tar.gz?raw=true -C /dero/ && rm dero_linux_amd64.tar.gz?raw=true

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# P2p 20202
# RPC 20206

EXPOSE 20202 20206

WORKDIR /dero

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
