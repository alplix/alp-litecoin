FROM ubuntu:22.04

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git \
    libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev \
    libssl-dev libdb-dev libdb++-dev

WORKDIR /opt/alp-litecoin
COPY . .

RUN ./autogen.sh && \
    ./configure --disable-wallet --without-gui --disable-tests --disable-bench --without-miniupnpc --disable-zmq --disable-rpc && \
    make -j$(nproc) && \
    install -m 755 src/litecoind /usr/local/bin/litecoind

ENTRYPOINT ["litecoind"]
