#!/bin/bash

export "JAVA_HOME=/opt/nextlabs/PolicyServer/java/jre"
export "JRE_HOME=/opt/nextlabs/PolicyServer/java/jre"
export "CATALINA_HOME=/opt/nextlabs/PolicyServer/server/tomcat"
export "CATALINA_TMP=/opt/nextlabs/PolicyServer/server/tomcat/temp"
export "CATALINA_BASE=/opt/nextlabs/PolicyServer/server/tomcat"
export "SERVER_XML=/opt/nextlabs/PolicyServer/server/configuration/server.xml"
export "JAVA_ENDORSED_DIRS=/opt/nextlabs/PolicyServer/server/tomcat/common/endorsed"
export "CLASSPATH=/opt/nextlabs/PolicyServer/server/tomcat/shared/lib/nxl-filehandler.jar"

export JAVA_OPTS="-Xmx2048m -Xms1024m -XX:MaxPermSize=512M -Dsun.lang.ClassLoader.allowArraySyntax=true -Xverify:none -Dorg.apache.commons.logging.Log=org.apache.commons.logging.impl.Jdk14Logger -Dserver.config.path=/opt/nextlabs/PolicyServer/server/configuration -Dcc.home=/opt/nextlabs/PolicyServer -Dserver.hostname=https://icenet.cloudaz.com -Dserver.name=https://icenet.cloudaz.com -Dconsole.install.mode=OPN  -Dlog4j.configurationFile=/opt/nextlabs/PolicyServer/server/configuration/log4j2.xml -Dlogging.config=file:/opt/nextlabs/PolicyServer/server/configuration/log4j2.xml -Dorg.springframework.boot.logging.LoggingSystem=none -Dspring.cloud.bootstrap.location=/opt/nextlabs/PolicyServer/server/configuration/bootstrap.properties -Djdk.tls.rejectClientInitiatedRenegotiation=true"


/opt/nextlabs/PolicyServer/server/tomcat/bin/startup.sh -config "/opt/nextlabs/PolicyServer/server/configuration/server.xml"
