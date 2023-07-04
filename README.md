## [CobaltStrike Update](https://cobaltstrike.vercel.app/)

![version](https://img.shields.io/badge/Version-4.5-da282a) [![Docker Automated Build](https://img.shields.io/docker/automated/xrsec/cobaltstrike?label=Build&logo=docker&style=flat-square)](https://hub.docker.com/r/xrsec/cobaltstrike) [![CobaltStrike Docker Build](https://github.com/XRSec/CobaltStrike-Docker/actions/workflows/CobaltStrike_Docker_Build.yml/badge.svg)](https://github.com/XRSec/CobaltStrike-Docker/actions/workflows/CobaltStrike_Docker_Build.yml)

[zh-cn](README_CN.md) | [en-us](README.md)

## Introduce

- A solution for you who don't want to build an environment and are afraid of software security
- If you want to use cloud functions, please be sure to open port 80,443
- ~~If the teamserver exists when mapping the directory, it will be overwritten~~
- In general, in order to prevent the certificate fingerprint information from being recognized universally, causing the server to be attacked, or the traffic contains obvious fingerprint features, it is recommended to use your own certificate
- The default startup item of the container is:, where the arg part is used to customize the agent startup method and CobaltStrike.jar
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
- Don't forget to modify the executable permissions`chmod +x teamserver`

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

- passwd : password
- server_ip : server ip
- server_port : server port
- alias_name : certificate alias name
- d_name : certificate information
- start_args : startup parameters
- 443 : https (Serverless Cloud Function)
- 80 : http (Serverless Cloud Function)
- 33009 : server management port

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

![image-20210903211149434](https://xrsec.s3.bitiful.net/IMG/20210903213218094679.png?fmt=webp&q=48)

![image-20210903211214909](https://xrsec.s3.bitiful.net/IMG/20210903213224154378.png?fmt=webp&q=48)

> XRSec has the right to modify and interpret this article. If you want to reprint or disseminate this article, you must ensure the integrity of this article, including all contents such as copyright notice. Without the permission of the author, the content of this article shall not be modified or increased or decreased arbitrarily, and it shall not be used for commercial purposes in any way
