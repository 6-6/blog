---
title: ngnix服务重启失败查错
date: 2021-07-27 14:37:51
tags: ngnix
categories: [服务器]
---

## 问题：
使用以下命令重启ngnix失败。
```
sudo service nginx restart
```

![shell界面](https://7675-vuepress-7g6mefe5ad729c51-1258812673.tcb.qcloud.la/Image/2021/ngnix/20210727-1.png?sign=d29ed8fd652903d068454d203bb5beb9&t=1627369061)

报错信息：
> Nginx: Failed to start A high performance web server and a reverse proxy server


## 分析：
使用以下命令，查找指定错误。
```
nginx -t -c /etc/nginx/nginx.conf
```

![输出结果](https://7675-vuepress-7g6mefe5ad729c51-1258812673.tcb.qcloud.la/Image/2021/ngnix/20210727-2.png?sign=26123be02a5befa122306d6b9ebba225&t=1627369105)

通过输出的结果，原来是nginx.conf 配置项有一个属性重复定义了

## 解决：
找到指定目录下的文件修改，删掉一个即可。

```
vim /etc/nginx/nginx.conf
```