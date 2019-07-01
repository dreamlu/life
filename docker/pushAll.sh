#!/bin/bash
# 私有/共有镜像地址
dockerUrl=registry.cn-hangzhou.aliyuncs.com/deercoder/dreamlu
# 批量推向私有仓库
docker images | grep ${dockerUrl} | awk '{print "docker push "$1":"$2}' | sh

# 删除空镜像
docker images|grep none|awk '{print $3 }'|xargs docker rmi

# 删除停止的容器
#docker rm `docker ps -a|grep Exited|awk '{print $1}'`

# ssh 登录
ssh ubuntu@ip
