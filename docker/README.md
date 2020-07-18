docker 部署系列  

- docker-compose单机  
- k8s(v1.18)多机器()  

> ps: k8s 回滚无缝更新rollout restart方式自动拉取镜像更新,某种因素要求高(目前猜测: 内存)  
> (线上真实项目崩了,后续通过rollout restart 单个慢慢无缝更新ok)  