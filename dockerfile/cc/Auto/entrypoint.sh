#!/bin/bash

find /opt/Nextlabs/PolicyServer/ -type f -exec  sed -i 's/${hostname}/${hostname}/g' {} +

# install postgrseq
rpm -ivh https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-3.noarch.rpm
yum -y install postgresql95

# UPDATE DATABASE TABLE SYS CONFIG
chmod 0644 /opt/Nextlabs/PolicyServer/dbinit.sql
psql -h db -U ccdbuser -d ccdb -f /opt/Nextlabs/PolicyServer/dbinit.sql

# Create Nextlabs User
adduser -r -s /bin/nologin nextlabs

# to encrypt db password
cd /opt/Nextlabs/PolicyServer/tools/crypt
encDbPass=`mkpassword.sh -password ${dbpassword}`

#s271736a45cd4f67130f14fd4024d72bf

cd /opt/Nextlabs/PolicyServer/server/logs
rm -rf *

cd /opt/Nextlabs/PolicyServer/server/certificates
# backup the old certs
mv web-keystore.jks web-keystore.jks-bak
mv web-truststore.jks web-truststore.jks-bak
mv web.cer web.cer-bak

/opt/Nextlabs/PolicyServer/java/bin/keytool -genkey -dname "cn=${hostname}" -alias secWeb -keypass NextNext2019! -storepass NextNext2019! -keyalg RSA -keystore web-keystore.jks

/opt/Nextlabs/PolicyServer/java/bin/keytool -export -alias secWeb -keypass NextNext2019! -storepass NextNext2019! -keystore web-keystore.jks -file web.cer

/opt/Nextlabs/PolicyServer/java/bin/keytool -noprompt -import -alias secWeb -keypass NextNext2019! -storepass NextNext2019! -keystore web-truststore.jks -file web.cer

/opt/Nextlabs/PolicyServer/java/bin/keytool -noprompt -import -alias dcc -keypass NextNext2019! -storepass NextNext2019! -keystore web-truststore.jks -file dcc.cer
# import mail server cert
/opt/Nextlabs/PolicyServer/java/bin/keytool -noprompt -import -alias mail -keypass NextNext2019! -storepass NextNext2019! -keystore web-truststore.jks -file /tmp/mailserver.cer

chown nextlabs:nextlabs *
chmod 755 -R web*
# TO LIST Cert (Password is NextNext2019!)
 # /opt/Nextlabs/PolicyServer/java/bin/keytool -list -v -keystore /opt/Nextlabs/PolicyServer/server/certificates/web-truststore.jks
# /opt/Nextlabs/PolicyServer/java/bin/keytool -list -v -keystore /opt/Nextlabs/PolicyServer/server/certificates/web-keystore.jks

chown -R nextlabs:nextlabs /opt/Nextlabs/PolicyServer/server/certificates/*
chmod -R 0755 /opt/Nextlabs/PolicyServer/server/certificates/*

export JAVA_HOME=/opt/Nextlabs/PolicyServer/java/jre
export JRE_HOME=/opt/Nextlabs/PolicyServer/java/jre
export CATALINA_HOME=/opt/Nextlabs/PolicyServer/server/tomcat
export CATALINA_TMP=/opt/Nextlabs/PolicyServer/server/tomcat/temp
export CATALINA_BASE=/opt/Nextlabs/PolicyServer/server/tomcat
export CATALINA_PID=/opt/Nextlabs/PolicyServer/CompliantEnterpriseServer-daemon.pid
export TOMCAT_USER=nextlabs
export SERVER_XML=/opt/Nextlabs/PolicyServer/server/configuration/server.xml
export JAVA_ENDORSED_DIRS=/opt/Nextlabs/PolicyServer/server/tomcat/common/endorsed
export CLASSPATH=/opt/Nextlabs/PolicyServer/server/tomcat/shared/lib/nxl-filehandler.jar



export JAVA_OPTS="-Xmx2048m -Xms1024m -XX:MaxPermSize=512M -Dsun.lang.ClassLoader.allowArraySyntax=true -Xverify:none -Dorg.apache.commons.logging.Log=org.apache.commons.logging.impl.Jdk14Logger -Dserver.config.path=/opt/Nextlabs/PolicyServer/server/configuration -Dcc.home=/opt/Nextlabs/PolicyServer -Dserver.hostname=${hostname} -Dserver.name=https://${hostname}:443 -Dconsole.install.mode=OPN  -Dlog4j.configurationFile=/opt/Nextlabs/PolicyServer/server/configuration/log4j2.xml -Dlogging.config=file:/opt/Nextlabs/PolicyServer/server/configuration/log4j2.xml -Dorg.springframework.boot.logging.LoggingSystem=none -Dspring.cloud.bootstrap.location=/opt/Nextlabs/PolicyServer/server/configuration/bootstrap.properties -Djdk.tls.rejectClientInitiatedRenegotiation=true"



# COPY the certificates and configuration file and make it available to ICENET
# (assumption /tmp:/tmp is mapped to cc and host)

cd /opt/Nextlabs/PolicyServer/server/configuration
mkdir -p /tmp/cc-to-icenet && cp bootstrap.properties /tmp/cc-to-icenet

cd /opt/Nextlabs/PolicyServer/server/certificates
cp * /tmp/cc-to-icenet

# start the service
# /opt/Nextlabs/PolicyServer/server/tomcat/bin/catalina.sh jpda run -config /opt/Nextlabs/PolicyServer/server/configuration/server.xml

/opt/nextlabs/PolicyServer/server/tomcat/bin/startup.sh -config "/opt/nextlabs/PolicyServer/server/configuration/server.xml"



