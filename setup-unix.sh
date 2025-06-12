#!/bin/bash
set -e

echo "[alp-litecoin] Starting portable UNIX build process..."

# Check for root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (e.g., with sudo)."
  exit 1
fi

# Detect OS and install dependencies
if command -v apt &>/dev/null; then
  echo "[alp-litecoin] Detected apt (Debian/Ubuntu)"
  apt update
  apt install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git \
    libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev \
    libssl-dev libdb-dev libdb++-dev
elif command -v dnf &>/dev/null; then
  echo "[alp-litecoin] Detected dnf (Fedora)"
  dnf install -y make automake gcc gcc-c++ kernel-devel libtool curl git \
    boost-devel libevent-devel openssl-devel libdb-devel libdb-cxx-devel
elif command -v pacman &>/dev/null; then
  echo "[alp-litecoin] Detected pacman (Arch)"
  pacman -Sy --noconfirm base-devel git boost libevent openssl db
elif command -v brew &>/dev/null; then
  echo "[alp-litecoin] Detected Homebrew (macOS)"
  brew install autoconf automake libtool boost openssl libevent berkeley-db@5
elif command -v pkg &>/dev/null; then
  echo "[alp-litecoin] Detected pkg (FreeBSD)"
  pkg install -y git gmake autoconf automake libtool boost-libs libevent openssl db5
else
  echo "❌ Unsupported package manager. Please install dependencies manually."
  exit 1
fi

# Go to script location
cd "$(dirname "$0")"

# Build process
./autogen.sh
./configure --disable-wallet --without-gui --disable-tests --disable-bench --without-miniupnpc --disable-zmq --without-libs --disable-rpc
make -j$(nproc)

# Install binary
install -m 755 src/litecoind /usr/local/bin/litecoind

echo "[alp-litecoin] Build complete. Run with: litecoind -conf=/your/path/litecoin.conf"
