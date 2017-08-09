FROM alpine:latest

RUN \
    apk update && apk add make && apk add gcc && apk add git && apk add curl && apk add musl-dev && \
    apk add perl && \
    curl -lOk http://pkgs.fedoraproject.org/repo/pkgs/cowsay/cowsay-3.03.tar.gz/b29169797359420dadb998079021a494/cowsay-3.03.tar.gz && \
    tar zxvf cowsay-3.03.tar.gz && \
    cd cowsay-3.03 && \
    ./install.sh && \
    git clone http://github.com/possatti/pokemonsay && \
    cd pokemonsay && \
    ./install.sh && \
    cp /root/bin/poke* /usr/local/bin/ && \
    cd && \
    rm -rf cowsay*

ENTRYPOINT ["pokemonsay"]
