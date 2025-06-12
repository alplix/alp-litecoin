#!/bin/bash
set -e
exec litecoind -conf=/home/litecoin/.litecoin/litecoin.conf -datadir=/home/litecoin/.litecoin "$@"
