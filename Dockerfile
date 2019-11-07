FROM golang:1.13.4-alpine3.10 as builder
RUN mkdir -p /go/src/pokesay
WORKDIR /go/src/pokesay
COPY . .
RUN go build ./...

FROM golang:1.13.4-alpine3.10

RUN apk update && \
  apk add git perl

RUN git clone git://github.com/schacon/cowsay && \
  cd cowsay && \
  git checkout b67eda47925e8dee3a3fd4b513127a3f4ae15341 && \
  sh install.sh

RUN git clone git://github.com/possatti/pokemonsay && \
  cd pokemonsay && \
  git checkout 73e67f6e778481333c584b57518c6f50ba57cabc && \
  sh install.sh

ENV PATH /usr/games:$PATH
WORKDIR /
COPY --from=builder /go/src/pokesay/pokesay .

ENTRYPOINT ["./pokesay"]

