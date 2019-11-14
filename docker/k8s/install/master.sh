#!/usr/bin/env bash
# master init
kubeadm init --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=all
# use flannel network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# nfs 安装
# 这里改成自己的nfs目录
echo "/root/yhf/data *(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
service nfs-kernel-server restart

# kubectl 提示
echo "source <(kubectl completion bash)" >> /root/.bashrc
