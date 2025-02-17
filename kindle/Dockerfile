FROM --platform=linux/arm/v7 debian:jessie AS armhf-base

ARG SNAPSHOT=20230304T144759Z
RUN echo "\n\
deb [check-valid-until=no] http://archive.debian.org/debian jessie main\n\
deb [check-valid-until=no] http://archive.debian.org/debian-security jessie/updates main\n\
deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main\n\
deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports-sloppy main\n\
" > /etc/apt/sources.list

RUN --mount=type=cache,target=/var/cache/apt \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get --option="APT::Acquire::Retries=10" install -y --force-yes \
        build-essential autoconf automake libtool pkg-config wget curl zip git \
        libpcre3-dev autotools-dev libssl-dev librhash-dev libcurl4-openssl-dev libexpat-dev libbz2-dev libarchive-dev liblzma-dev libuv0.10-dev zlib1g-dev


ARG GOVER=1.24.0
ENV PATH=${PATH}:/usr/local/go/bin
WORKDIR /root/build
RUN --mount=type=tmpfs,target=/root/build \
    wget "https://go.dev/dl/go$GOVER.linux-armv6l.tar.gz" && \
    tar -C /usr/local -xzf go*.linux-armv6l.tar.gz && \
    go version

COPY script/build-cmake.sh /root
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/root/build \
    --mount=type=bind,target=/script,source=script \
    /script/build-cmake.sh

ENV GOARCH=arm
ENV GOARM=7
ENV CGO_ENABLED=0
ENV CGO_CFLAGS=""
ENV CGO_LDFLAGS=""
    
