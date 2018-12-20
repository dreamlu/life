#!/bin/bash
# crontab :30 2 * * * /root/xx/bak.sh
echo "进入${1}目录进行备份"
cd /root/$1/ 
DATE=`date +%Y%m%d`
OLD=`date -d"1 day ago" +"%Y%m%d"`
OLD3=`date -d"3 day ago" +"%Y%m%d"`
USER=`cat /etc/mysql/debian.cnf |grep user|head -1|awk  '{print $3}'`
PASSWORD=`cat /etc/mysql/debian.cnf |grep password|head -1|awk  '{print $3}'`
DATABASE="$1"

mysqldump -R $DATABASE -u$USER -p$PASSWORD | bzip2 > $1_${DATE}.sql.bz2
if tar cjf $1_${DATE}.tar.bz2 static/file/ $1_${DATE}.sql.bz2; then
	rm $1_${OLD3}.tar.bz2
	rm $1_${OLD}.sql.bz2
fi
