FROM ubuntu:bionic-20190612

ENV MYSQL_USER=mysql \
    MYSQL_VERSION=5.7 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server=${MYSQL_VERSION}* \
 && rm -rf ${MYSQL_DATA_DIR} \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
COPY mysql_backup/sh_dump.sql /sbin/sh_dump.sql

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3306/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/bin/mysqld_safe"]
