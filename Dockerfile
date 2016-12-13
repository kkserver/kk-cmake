FROM alpine:latest

MAINTAINER hailongz "hailongz@qq.com"

RUN apk add --update --repository http://mirrors.aliyun.com/alpine/v3.4/main/ \
	 --repository http://mirrors.aliyun.com/alpine/v3.4/community/ \
	  gcc libc-dev curl make readline-dev ncurses-dev libevent-dev bash && rm -rf /var/cache/apk/* 

WORKDIR /

RUN curl -R -O http://www.lua.org/ftp/lua-5.2.4.tar.gz

RUN tar zxf lua-5.2.4.tar.gz

WORKDIR /lua-5.2.4

RUN ls

RUN make linux

RUN make install

WORKDIR /

RUN ln -s /usr/local/lib/liblua.a /usr/local/lib/liblua5.2.a

RUN rm -rf lua-5.2.4

RUN rm -f lua-5.2.4.tar.gz

RUN echo "Asia/shanghai" >> /etc/timezone

VOLUME /main

WORKDIR /main

CMD make build
