FROM xrsec/java:latest
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"

ADD cobaltstrike.zip /
COPY Dockerfile /cobaltstrike

RUN ls / && ls /cobaltstrike && yum update -y && yum upgrade -y \
    && yum install sudo ncurses langpacks-zh_CN.noarch -y \
    && chmod 777 /cobaltstrike/teamserver

ENV server_ip 127.0.0.1
ENV server_port 33009
ENV aliasname "cloud.tencent.com"
ENV dname "CN=cloud.tencent.com,  OU=Tencent Technology (Shenzhen) Company Limited, O=Tencent Technology (Shenzhen) Company Limited, L=Shenzhen, S=Guangdong Province, C=CN"
ENV LANG zh_CN.utf8
ENV TZ Asia/Shanghai

STOPSIGNAL SIGWINCH

EXPOSE 50050 80 443 33009
CMD ["/cobaltstrike/teamserver"]