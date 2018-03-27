FROM ubuntu:16.04

LABEL maintainer="ResolveWang <resolvewang@foxmail.com>"

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
RUN apt update \
    && apt install squid -yq \
    && sed -i 's/http_access deny all/http_access allow all/g' /etc/squid/squid.conf \
    && apt install python3 python3-pip -yq \
    && which python3|xargs -i ln -s {} /usr/bin/python \
    && which pip3|xargs -i ln -s {} /usr/bin/pip
COPY . /haipproxy
WORKDIR /haipproxy
RUN pip install --upgrade pip && pip install -i https://pypi.douban.com/simple/ -r requirements.txt
CMD ["python", "crawler_booter.py", "--usage", "crawler", "common"]
