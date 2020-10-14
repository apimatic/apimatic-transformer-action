# Every Action needs a Dockerfile
FROM alpine
RUN	apk add --no-cache bash curl jq
COPY comment.sh /comment.sh
ENTRYPOINT ["/comment.sh"]
