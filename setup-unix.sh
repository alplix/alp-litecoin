#!/bin/bash
set -e

echo "[alp-litecoin] Starting full node setup..."

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g. with sudo)."
  exit 1
fi

# Detect package manager and install dependencies
if command -v apt &>/dev/null; then
  apt update
  apt install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git \
    libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev \
    libssl-dev libdb-dev libdb++-dev
elif command -v dnf &>/dev/null; then
  dnf install -y make automake gcc gcc-c++ kernel-devel libtool curl git \
    boost-devel libevent-devel openssl-devel libdb-devel libdb-cxx-devel
elif command -v pacman &>/dev/null; then
  pacman -Sy --noconfirm base-devel git boost libevent openssl db
elif command -v brew &>/dev/null; then
  brew install autoconf automake libtool boost openssl libevent berkeley-db@5
elif command -v pkg &>/dev/null; then
  pkg install -y git gmake autoconf automake libtool boost-libs libevent openssl db5
else
  echo "Unsupported package manager."
  exit 1
fi

# Create litecoin user if not exists
id -u litecoin &>/dev/null || useradd -r -m -s /bin/false litecoin

# Build from source
cd "$(dirname "$0")"
chmod +x ./autogen.sh
./autogen.sh
./configure --disable-wallet --without-gui --disable-tests --disable-bench --without-miniupnpc --disable-zmq --disable-rpc
make -j$(nproc)

# Install binary
install -m 755 src/litecoind /usr/local/bin/litecoind

# Setup runtime directory
mkdir -p /opt/alp-litecoin
cp -f litecoin.conf /opt/alp-litecoin/litecoin.conf 2>/dev/null || echo "txindex=1\ndaemon=1\nserver=0" > /opt/alp-litecoin/litecoin.conf
chown -R litecoin:litecoin /opt/alp-litecoin

# Install systemd service
cat <<EOF > /etc/systemd/system/alp-litecoin.service
[Unit]
Description=alp-litecoin daemon
After=network.target

[Service]
User=litecoin
ExecStart=/usr/local/bin/litecoind -conf=/opt/alp-litecoin/litecoin.conf -datadir=/opt/alp-litecoin
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable alp-litecoin

echo "[alp-litecoin] Setup complete."
echo "Start the node with: sudo systemctl start alp-litecoin"