FROM mongo:3.4

RUN apt-get update && \
    apt-get install -y \
                    rsync

WORKDIR /data/bin

CMD ["./run.sh"]

COPY ./bin/*.sh ./
