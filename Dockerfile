# Every Action needs a Dockerfile
FROM alpine
RUN	apk add --no-cache bash curl jq pacman
RUN pacman -S jshon
COPY comment.sh /comment.sh
ENTRYPOINT ["sh","/comment.sh"]
