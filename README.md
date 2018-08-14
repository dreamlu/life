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
 

----------
运行：

复制 upload.sh、deercoder.sh到go web 根目录下

./upload.sh

详情：
upload.sh(替换ip、password 、uploadDir(上传目录))

```
#!/bin/bash
#upload.sh made by lucheng
#server ip and password
ip=
password=
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
注:服务器如有go环境可以去掉deercoder.sh最后几行的注释,可以在未编译或编译出错时，线上进行编译执行服务
*欢迎关注,go web脚本更新,如有需要请联系我，star一下，猿一枚～*