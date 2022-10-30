FROM centos:7.6.1810
LABEL Maintainer="Nextlabs"

ARG HOSTNAME=${HOSTNAME}

RUN ln -sf /usr/share/zoneinfo/PST8PDT /etc/localtime

COPY PolicyServer /opt/Nextlabs/PolicyServer
COPY entrypoint.sh /opt/Nextlabs/PolicyServer/entrypoint.sh
COPY dbinit.sql /opt/Nextlabs/PolicyServer/dbinit.sql

RUN chmod +x /opt/Nextlabs/PolicyServer/entrypoint.sh

CMD  entrypoint.sh