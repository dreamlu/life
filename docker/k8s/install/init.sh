#!/usr/bin/env bash
# add k8s
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
# k8s update/install
apt update
apt upgrade -y
apt install docker.io kubeadm kubelet kubernetes-cni -y
# echo "source <(kubectl completion bash)" >> /root/.bashrc
# nfs
apt install nfs-kernel-server -y
