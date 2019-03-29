FROM mongo:3.4

RUN apt-get update && \
    apt-get install -y \
                    rsync

WORKDIR /data

CMD ["./run.sh"]

COPY *.sh ./
