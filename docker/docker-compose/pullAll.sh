#!/bin/bash
# 镜像标志(关键字)
key=gt-crud
# 批量拉取镜像
cat docker-compose.yaml  | grep ${key} | awk '{print "sudo docker pull "$2}' | sh

# 删除空镜像
docker images|grep none|awk '{print $3 }'|xargs docker rmi