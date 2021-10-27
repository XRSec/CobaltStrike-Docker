FROM xrsec/java:latest
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"
LABEL Github="https://github.com/XRSec/Code-Server-Update"

COPY cobaltstrike.zip /

RUN yum update -y && yum upgrade -y \
    && yum install sudo ncurses langpacks-zh_CN.noarch -y \
    && unzip -P'${{ secrets.DOCKERHUB_REGISTRY }}' /cobaltstrike.zip -d /cobaltstrike \
    && unzip -P'${{ secrets.DOCKERHUB_REGISTRY }}' /cobaltstrike/cobaltstrike.zip -d /cobaltstrike \
    && rm -rf /cobaltstrike/cobaltstrike.zip \
    && chmod 777 /cobaltstrike/teamserver

COPY Dockerfile /cobaltstrike
WORKDIR /cobaltstrike
ENV server_ip 127.0.0.1
ENV server_port 33009
ENV aliasname "cloud.tencent.com"
ENV dname "CN=cloud.tencent.com,  OU=Tencent Technology (Shenzhen) Company Limited, O=Tencent Technology (Shenzhen) Company Limited, L=Shenzhen, S=Guangdong Province, C=CN"
ENV TZ Asia/Shanghai
ENV LANG en_US.utf8

STOPSIGNAL SIGWINCH
EXPOSE 50050 80 443 33009
CMD ["/cobaltstrike/teamserver"]
