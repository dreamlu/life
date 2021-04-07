# docker-compose 一键部署定时备份

- docker-compose 一键部署定时备份
- 不再需要挂载目录
- [备份详情](mysql/bak.sh)
- 本机备份,查看backup.sh, 去除-c 容器选项即可  

### 作用  
1.`backup.sh`备份  
2.`pullAll.sh`拉取线上镜像  
3.`pushALL.sh`推送本地镜像(本地)  
4.`scp.sh`初次部署，配置免密、安装软件、上传部署文件(本地)  
5.`update.sh`后续项目本地执行更新(本地)  
