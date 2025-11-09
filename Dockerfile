FROM node:25.1.0-bookworm

RUN npm i -g opencode-ai@v1.0.51
RUN set -ex \
  && apt-get update \
  && apt-get install -y netcat-traditional \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN  mkdir /app && chown node:node -R /app
USER node
HEALTHCHECK --interval=5m --timeout=30s --retries=3 CMD bash -c "nc -z 127.0.0.1 8080"
EXPOSE 80/tcp
VOLUME /app
WORKDIR /app
ENTRYPOINT ["opencode", "serve", "--hostname", "0.0.0.0", "--port", "8080"]
