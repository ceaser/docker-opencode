FROM node:25.1.0-bookworm

RUN npm i -g opencode-ai@v1.0.51

ENV OPENCODE_HOSTNAME=0.0.0.0
ENV OPENCODE_PORT=80

RUN set -ex \
  && apt-get update \
  && apt-get install -y netcat-traditional \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

HEALTHCHECK --interval=5m --timeout=30s --retries=3 CMD bash -c "nc -z 127.0.0.1 80"
EXPOSE 80/tcp
ENTRYPOINT ["opencode", "serve", "--hostname", "0.0.0.0", "--port", "80"]
