FROM xrsec/java:latest
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"
LABEL Github="https://github.com/XRSec/Code-Server-Update"

COPY cobaltstrike /cobaltstrike
COPY Dockerfile /cobaltstrike
WORKDIR /cobaltstrike

RUN yum update -y && yum upgrade -y \
#     && yum install sudo ncurses unzip langpacks-zh_CN.noarch -y \
    && yum install ncurses -y \
#     && yum groupinstall Fonts -y \
    && yum clean all -y \
    && chmod 777 /cobaltstrike/teamserver

ENV server_ip 127.0.0.1
ENV server_port 33009
ENV aliasname "cloud.tencent.com"
ENV dname "CN=cloud.tencent.com,  OU=Tencent Technology (Shenzhen) Company Limited, O=Tencent Technology (Shenzhen) Company Limited, L=Shenzhen, S=Guangdong Province, C=CN"
ENV TZ='Asia/Shanghai'
ENV LANG 'zh_CN.UTF-8'

STOPSIGNAL SIGWINCH
EXPOSE 50050 80 443 33009
CMD ["/cobaltstrike/teamserver"]
