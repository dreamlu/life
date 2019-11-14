#!/bin/bash
# 判断sendemail是否安装
if ! [[ -x "$(command -v sendemail)" ]]; then
  echo 'Error: sendemail is not installed.' >&2
  sudo apt install sendemail -y
fi
# 参数
account=3147460271@qq.com #发件箱
password=xxx #发件箱密码(授权码)
SMTP_server=smtp.qq.com #发件箱对应的stmp服务器
to=3147460271@qq.com #参数(收件箱)
subject=备份数据 #参数(主题)
content=测试 #参数(内容)
filePath= #文件(附件)

sendemail -f ${account} -t ${to} -s smtp.qq.com -u ${subject} -xu ${account} -xp ${password} -m ${content} -a ${filePath}