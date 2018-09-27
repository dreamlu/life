### go web一键上传程序并执行服务脚本

即将大四学生党一枚,个人学习golang web中,工作中遇到客户总改需求，经常需要重新编译打包上传,关闭旧服务，启动新服务......脚本便诞生了

###### 项目地址:[https://github.com/Dreamlu/deercoder-go.sh](https://github.com/Dreamlu/deercoder-go.sh)

原理：

 - shell命令
 - scp远程复制(liunx通用命令)
 - expect进行交互输入密码(免密登录方式,每次重装系统后都要重新弄,本人喜欢折腾..em...弃)
 - ssh
 - expect的spawn执行线上脚本
 - go build打包编译
 - 新旧进程的替换pid
 - 新增单个go build -o xxx 文件的编译、打包、上传、执行、退出
 

----------
运行：

复制 upload.sh、deercoder.sh到go web 根目录下

./upload.sh

详情：
upload.sh(替换ip、password 、uploadDir(上传目录))

```
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
```
deercoder.sh(go web 执行脚本)

```
#!/bin/bash
#deercoder.sh made by lucheng
#if some error,connect me:wechat:a_862362681
#get programe's name the same as directory
curDir=$(basename `pwd`)
echo "current dir's or programe's name is $curDir"

#execute the programe
#delete old process
pid=$(ps aux | grep $curDir | grep -v grep | awk '{print $2}')
if [ "$pid" ]
then
    echo "$curDir programe is running, pid is $pid"
    echo "the script will try to kill it and start new progress"
    # delete this old process
    kill -9 $pid
else
    echo "no old process"
fi

#start new daemon	
nohup ./$curDir &
pid=$(ps aux | grep $curDir | grep -v grep | awk '{print $2}')
if [ "$pid" ]
then
    echo "the programe's new pid id $pid"
else
    echo "no such process: $curDir"
    echo "please try to compile and upload it"
    #go build
    #echo "is tring to execute the script itself"
    #execute current script file
    #./$0
fi
```

up.sh(上传单个go build -o xxx文件并编译执行)

用法：配置ip免密ssh，执行./up.sh xxx(指定编译文件名)

```
#!/bin/bash
#ssh no secret run cmd
#up.sh made by lucheng
#version 1.1
#server ip
ip=
uploadDir=root
#directory
curDir=$(basename `pwd`)
#get the newest go build processname
go build -o $1
echo "compress tar.gz is running..."
tar -zcf $1.tar.gz $1
echo "$1 compile finished"
echo "now upload the file"
scp $1.tar.gz root@$ip:/$uploadDir/$1
echo "$1 upload finshed"
echo "and now restart the programe"
ssh root@$ip "
> /dev/null 2>&1 << EOF
    cd $1
    tar -zxf $1.tar.gz
    ./deercoder.sh
    exit
EOF"
echo "upload and run over,remove $1.tar.gz"
rm -rf $1.tar.gz
#echo "2s later exit"
#sleep 2
#exit
```

注:服务器如有go环境可以去掉deercoder.sh最后几行的注释,可以在未编译或编译出错时，线上进行编译执行服务
*欢迎关注,go web脚本更新,如有需要请联系我，star一下，猿一枚～*
