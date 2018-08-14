#!/bin/bash
#upload.sh made by lucheng
#server ip and password
ip=47.94.8.188
password=lucheng
uploadDir=root
#get the newest go build
go build
#directory
curDir=$(basename `pwd`)
#upload current directory and file
#$echo $password | scp -r `pwd` root@$ip:/$uploadDir/
#expect
expect<<EOF
set timeout 200
spawn scp -r `pwd` root@$ip:/$uploadDir/
expect "password:" 
send "$password\r"
expect eof

#try to run script
spawn ssh root@$ip "
echo 'upload over,try to run progress script deercoder.sh';
cd /$uploadDir/$curDir;
./deercoder.sh "
expect "password:" 
send "$password\r"
expect eof
EOF
