FROM pataquets/nodejs

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends git \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
  && \
  git clone --single-branch --branch master https://github.com/etsy/statsd.git && \
  cd /statsd && \
  cp -v exampleConfig.js config.js && \
  sed -i 's/graphite.example.com/graphite/' config.js

WORKDIR /statsd

EXPOSE 8125/udp
EXPOSE 8126

ENTRYPOINT [ "node", "stats.js", "config.js" ]
