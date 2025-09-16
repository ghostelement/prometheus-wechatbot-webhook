FROM alpine:latest
#ARM版使用debian arm64镜像
#FROM debian:latest-arm
LABEL maintainer="leon"
ENV VERSION 1.0
WORKDIR /apps 
ADD  src/app /apps/app
RUN  chmod +x /apps/app && sed -i 's#http://deb.debian.org#http://mirrors.ustc.edu.cn#g' /etc/apt/sources.list.d/debian.sources && apt-get update && apt-get install -y procps inetutils-ping ca-certificates && rm -rf /tmp/*
#设置时区
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone
ADD src/wechatbot.tmpl /apps/wechatbot.tmpl
EXPOSE 9080 
CMD ["/apps/app"]