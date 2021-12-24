FROM rclone/rclone

RUN apk update && apk add mariadb-client bash

ENV MYSQL_HOST=localhost
ENV MYSQL_USER=root
ENV MYSQL_PASS=
ENV MYSQL_DB=
ENV RCLONE_TOKEN=
ENV DEST_DIR=/

COPY copy.sh /copy.sh

ENTRYPOINT [ "/bin/bash", "/copy.sh" ]

