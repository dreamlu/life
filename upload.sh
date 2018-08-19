#!/bin/bash
#upload.sh made by lucheng
#version 1.1
#server ip and password
ip=
password=
uploadDir=root
#get the newest go build
go build
#directory
curDir=$(basename `pwd`)
cd `pwd`
cd ..
#compress the file
echo "compress tar.gz is running..."
tar -zcf $curDir.tar.gz $curDir
echo "compress finshed,try to upload file..."
#upload the tar.gz file
#use expect input the password and execute shell
expect<<EOF
set timeout 20
spawn scp -r $curDir.tar.gz root@$ip:/$uploadDir/
expect "password:" 
send "$password\r"
expect eof

#decompress tar.gz and try to run script
spawn ssh root@$ip "
echo 'upload over,try to decompress tar.gz';
cd /$uploadDir/;
tar -zxf $curDir.tar.gz;
echo 'decompress finshed,try to run progress script deercoder.sh\n';
cd $curDir/;
./deercoder.sh "
expect "password:"
send "$password\r"

#interact      #用exact这个指令是为了把控制权交给用户，代替send "logout\r"    终端不会断开
expect eof
EOF
