## [CobaltStrike Update](https://cobaltstrike.vercel.app/)

![version](https://img.shields.io/badge/Version-4.5-da282a) [![Docker Automated Build](https://img.shields.io/docker/automated/xrsec/cobaltstrike?label=Build&logo=docker&style=flat-square)](https://hub.docker.com/r/xrsec/cobaltstrike) [![CobaltStrike Docker Build](https://github.com/XRSec/CobaltStrike-Docker/actions/workflows/CobaltStrike_Docker_Build.yml/badge.svg)](https://github.com/XRSec/CobaltStrike-Docker/actions/workflows/CobaltStrike_Docker_Build.yml)

[zh-cn](README_CN.md) | [en-us](README.md)

## Introduce

- 给不想搭建环境 并且害怕软件安全性的你一个解决方案
- 如果你想使用云函数，请务必开放80,443端口
- ~~映射目录时如果teamserver 存在将被覆盖~~
- 一般情况下，为了防止证书指纹信息是通用的被识别，导致服务器被攻击，或者流量中含有很明显的指纹特征，建议使用自己的证书
- 容器的默认启动项为:,其中 arg 部分用于自定义 agent 启动方式 以及 CobaltStrike.jar
    ```bash
    java -XX:ParallelGCThreads=4 \
    -Dcobaltstrike.server_port="${server_port}" \
    -Dcobaltstrike.server_bindto=0.0.0.0 \
    -Djavax.net.ssl.keyStore=/app/cobaltstrike.store \
    -Djavax.net.ssl.keyStorePassword="${passwd}" \
    -XX:+AggressiveHeap -XX:+UseParallelGC \
    -Xms512M -Xmx1024M -Duser.language=UTF-8 \
    -server "${start_args}" "${server_ip}" "${passwd}"

    Default: start_args='-classpath /app/cobaltstrike.jar \
    -javaagent:CSAgent.jar=f38eb3d1a335b252b58bc2acde81b542 \
    server.TeamServer'
    ```
- 别忘记修改可执行权限`chmod +x teamserver`

## Quickly create

```bash
docker run -it \
   --name cs \
   -e "passwd=e9PrFYtrPFD2U" \
   -e "server_ip=1.1.1.1" \
   -e "server_port=33009" \
   -e "alias_name=Bing Wallpaper" \
   -e "d_name=CN=www.microsoft.com,  OU=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=WA, C=US" \
   -e 'start_args=-server -classpath /app/cobaltstrike.jar -javaagent:CSAgent.jar=f38eb3d1a335b252b58bc2acde81b542 server.TeamServer' \
   -p 443:443 \
   -p 443:443/udp \
   -p 80:80 \
   -p 33009:33009 \
   -p 33009:33009/udp \
   -v /Users/hacker/Documents/CobaltStrike:/app \
   --restart=always \
   xrsec/cobaltstrike:latest
```

#### ARGS

-passwd : password
- server_ip : server ip
- server_port : server port
- alias_name : self-signed certificate common name
- d_name : self-signed certificate organization information
- start_args : custom server startup parameters
- 443 : HTTPS cloud function/CDN mandatory port
- 80 : http cloud function/CDN mandatory port
- 33009 : Remote management connection port

#### Tree

```yaml
➜  /Users/hacker/Documents ✗ tree
.
└─ CobaltStrike
     ├─ CSAgent.jar
     ├─ cobaltstrike.jar
     ├─ teamserver
     ├─ resources
     │         ├─ bdetails.txt
     │         ├─ bhelp.txt
     │         └─ translation.txt
     ├─ scripts
     │         └─ default.cna
     ├─ teamserver
     └─ third-party
         ├─ README.winvnc.txt
         ├─ winvnc.x64.dll
         └─ winvnc.x86.dll

5 directories, 13 files
```

### Preview

![image-20210903211149434](https://dogefs.s3.ladydaily.com/ZYGG/storage/20210903213218094679.png?fmt=webp&q=48)

![image-20210903211214909](https://dogefs.s3.ladydaily.com/ZYGG/storage/20210903213224154378.png?fmt=webp&q=48)

> XRSec has the right to modify and interpret this article. If you want to reprint or disseminate this article, you must ensure the integrity of this article, including all contents such as copyright notice. Without the permission of the author, the content of this article shall not be modified or increased or decreased arbitrarily, and it shall not be used for commercial purposes in any way
