#!/usr/bin/env bash
# go版shadows安装
yum update -y
wget https://github.com/shadowsocks/go-shadowsocks2/releases/download/v0.1.0/shadowsocks2-linux.gz
gzip -d shadowsocks2-linux.gz
service firewalld stop
nohup ./shadowsocks2-linux -s 'ss://AEAD_CHACHA20_POLY1305:dreamlu@:8488' -verbose &