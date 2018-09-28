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

#judge has $curDir.tar.gz, if has, update it
if [ -f "$curDir.tar.gz" ];then
    echo "there is tar -zxf $curDir.tar.gz file"
    echo "remove the $curDir file and update it,then remove the $curDir.tar.gz"
    rm $curDir
    tar -zxf $curDir.tar.gz
    rm $curDir.tar.gz
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
