#!/usr/bin/env bash
yum update -y
service firewalld stop
yum install docker -y
service docker restart
docker run --name ipsec-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp -d --privileged -e VPN_USER=dreamlu -e VPN_PASSWORD=dreamlu -e VPN_IPSEC_PSK=dreamlu hwdsl2/ipsec-vpn-server
docker logs ipsec-vpn-server