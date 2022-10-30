#!/bin/sh
set -e

# DELETE LOGS
rm -rf /usr/share/tomcat8/nextlabs/logs/*

find /usr/share/tomcat8/nextlabs -type f -exec  sed -i 's/icenet/${hostname}/g' {} +

export CATALINA_HOME=/usr/share/tomcat8

/usr/share/tomcat8/bin/catalina.sh start
