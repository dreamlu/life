#!/bin/bash
# 目录名与数据库名保持一致
if [ $# -lt 1 ]; then 
    	echo "请输入数据库名称,重新执行"
	exit
fi
bakdir="/etc/crontab"
if [ ! -f "$bakdir" ]; then
  	touch $bakdir
else
  	echo "定时任务文件${bakdir}已存在"
fi

if grep "bak.sh" $bakdir ; then
	echo "auto backup added!"
else
	echo -e "#定时备份${1}数据\n1 2 * * * root /root/$1/bak.sh $1" >> $bakdir
	echo "定时备份==> ${1} 中的数据"
fi
