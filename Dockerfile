# Every Action needs a Dockerfile
FROM alpine
RUN	apk add --no-cache bash curl jq
COPY comment /usr/bin/comment
ENTRYPOINT ["comment"]