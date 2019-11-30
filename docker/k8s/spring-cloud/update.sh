#!/usr/bin/env bash
# k8s 更新执行
# 一次定时任务
# apt install at -y
at 02:01 << EOF
echo "\nhello" >> pushAll.sh
kubectl delete -f client-service-deployment.yaml -f shop-service-deployment.yaml -f common-service-deployment.yaml -f staff-service-deployment.yaml -f api-gateway-deployment.yaml
kubectl apply -f .
EOF
# 查看结果
echo -e "更新时间:"
at -l
#exit