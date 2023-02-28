FROM xrsec/java:latest
LABEL maintainer="xrsec"
LABEL mail="Jalapeno1868@outlook.com"
LABEL Github="https://github.com/XRSec/CobaltStrike-Docker"
LABEL org.opencontainers.image.source="https://github.com/XRSec/CobaltStrike-Docker"
LABEL org.opencontainers.image.title="CobaltStrike"

COPY teamserver /
COPY Dockerfile /

RUN yum update -y && yum upgrade -y \
    && yum install sudo ncurses unzip langpacks-zh_CN.noarch -y \
    && yum groupinstall Fonts -y \
    && yum clean all -y \
    && mkdir /app \
    && chmod +x /teamserver

WORKDIR /app

ENV server_ip 127.0.0.1
ENV server_port 33009
ENV alias_name "cloud.tencent.com"
ENV d_name "CN=cloud.tencent.com, OU=Tencent Technology (Shenzhen) Company Limited, O=Tencent Technology (Shenzhen) Company Limited, L=Shenzhen, S=Guangdong Province, C=CN"
ENV start_args '-classpath /app/cobaltstrike.jar -javaagent:CSAgent.jar=f38eb3d1a335b252b58bc2acde81b542 server.TeamServer'

ENV TZ='Asia/Shanghai'
ENV LANG 'zh_CN.UTF-8'

STOPSIGNAL SIGWINCH
EXPOSE 50050 80 443 33009
CMD ["/teamserver"]
