# Every Action needs a Dockerfile
FROM alpine
RUN	apk add --no-cache bash curl jq jshon
COPY comment.sh /comment.sh
ENTRYPOINT ["sh","/comment.sh"]
