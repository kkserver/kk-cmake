FROM alpine:latest

MAINTAINER hailongz "hailongz@qq.com"

RUN apk add --update --repository http://mirrors.aliyun.com/alpine/v3.4/main/ \
	 --repository http://mirrors.aliyun.com/alpine/v3.4/community/ \
	  gcc libc-dev make readline-dev ncurses-dev bash linux-headers bsd-compat-headers python file && rm -rf /var/cache/apk/* 

WORKDIR /

#lua-5.3.0
COPY ./lib/include/lua /usr/local/include
COPY ./lib/lua-5.3.0 lua-5.3.0
WORKDIR /lua-5.3.0
RUN make linux
RUN cp src/liblua.a /usr/local/lib/liblua.a
WORKDIR /
RUN rm -rf lua-5.3.0

#libevent-2.0.22-stable
COPY ./lib/include/event /usr/local/include
COPY ./lib/libevent-2.0.22-stable libevent-2.0.22-stable
WORKDIR /libevent-2.0.22-stable
RUN ./configure --enable-static
RUN make
RUN cp .libs/libevent.a /usr/local/lib/libevent.a
WORKDIR /
RUN rm -rf libevent-2.0.22-stable

RUN echo "Asia/shanghai" >> /etc/timezone

VOLUME /main

WORKDIR /main

CMD make build
