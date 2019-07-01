#!/bin/bash
# 镜像标志(关键字)
key=ykb-
# 批量拉取镜像
cat docker-compose.yaml  | grep ${key} | awk '{print "sudo docker pull "$2}' | sh