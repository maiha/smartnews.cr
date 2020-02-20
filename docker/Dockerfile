FROM crystallang/crystal:0.33.0
LABEL maintainer "maiha <maiha@wota.jp>"

# Static library dependencies are fragile, so specify the version exactly.
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  libcurl4-openssl-dev \
  libidn2-0-dev \
  libunistring-dev

CMD ["crystal", "--version"]
