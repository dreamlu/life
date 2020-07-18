### work shell
install  
```bash
wget https://github.com/dreamlu/shell/raw/master/life/shadows/install_centos.sh
chmod 755 ./install_centos.sh
./install_centos.sh
```
test  
```bash
ps aux | grep shadowsocks
```

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