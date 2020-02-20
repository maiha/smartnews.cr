FROM crystallang/crystal:0.33.0-alpine
LABEL maintainer "maiha <maiha@wota.jp>"

RUN echo "@edge http://mirror.xtom.com.hk/alpine/edge/main" >> /etc/apk/repositories

RUN apk update && apk add --no-cache \
    curl-static@edge \
    libidn2-static@edge \
    nghttp2-static@edge \
    && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

CMD ["crystal", "--version"]
