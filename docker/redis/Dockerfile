FROM redis:alpine
WORKDIR /redis
# TODO: 必要に応じて設定ファイルの雛形を用意する
# COPY redis.conf /usr/local/etc/redis/redis.conf
COPY init.sh ./
RUN chmod +x init.sh