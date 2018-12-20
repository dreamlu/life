#!/bin/bash
bakdir="/var/spool/cron/crontabs/root"
if [ ! -f "$bakdir" ]; then
  touch $bakdir
else
  echo "定时备份文件已存在"
fi

if grep "bak.sh" $bakdir ; then
	echo "auto backup added!"
else
	echo "34 17 * * * /root/$1/bak.sh $1" >> $bakdir
fi
