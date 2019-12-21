#!/bin/bash
# 私有/共有镜像地址
dockerUrl=registry.cn-hangzhou.aliyuncs.com/deercoder/dreamlu #registry.gitlab.com/dreamlu/micro-go
# 批量推向私有仓库
docker images | grep ${dockerUrl} | awk '{print "docker push "$1":"$2}' | sh

# 删除空镜像
docker images|grep none|awk '{print $3 }'|xargs docker rmi

# 删除停止的容器
#docker rm `docker ps -a|grep Exited|awk '{print $1}'`

# ssh 登录
# 执行更新脚本, 取消ssh命令后面注释
# 进入在线部署的目录, 执行更新脚本, 退出
# [一键进行推送更新部署]
ssh ubuntu@ip #"cd shell/docker/k8s;./update.sh;exit"
