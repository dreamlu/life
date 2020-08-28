### lpsrc_vpn

vpn, 系统全局代理  
[来源](https://github.com/hwdsl2/docker-ipsec-vpn-server/blob/master/README-zh.md)  
install  
```bash
wget https://github.com/dreamlu/shell/raw/master/life/lpsec_vpn/install_centos_vpn.sh
chmod 755 ./install_centos_vpn.sh
./install_centos_vpn.sh
```
test  
```bash
docker exec -it ipsec-vpn-server ipsec status
```  
客户端(linux/android/等)配置参考：[客户端配置](https://github.com/hwdsl2/setup-ipsec-vpn/blob/master/docs/clients-zh.md)  

加速:  
```bash
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x bbr.sh
./bbr.sh
```
test  
```bash
lsmod | grep bbr
```