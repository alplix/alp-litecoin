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

RUN useradd -r -m litecoin && mkdir -p /opt/alp-litecoin && \
    chown -R litecoin:litecoin /opt/alp-litecoin

COPY litecoin.conf /opt/alp-litecoin/litecoin.conf
RUN chown litecoin:litecoin /opt/alp-litecoin/litecoin.conf

USER litecoin
ENTRYPOINT ["/usr/local/bin/litecoind", "-conf=/opt/alp-litecoin/litecoin.conf", "-datadir=/opt/alp-litecoin"]
