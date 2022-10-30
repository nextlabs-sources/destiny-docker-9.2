FROM alpine:3.7
LABEL Maintainer="Nextlabs"

ARG HOSTNAME=${HOSTNAME}

RUN apk update && \
    apk add unzip && \
    apk add bash && \
    apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip &&\
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories && \
    apk add openjdk8 && \ 
    apk cache clean && \
    ln -sf /usr/share/zoneinfo/PST8PDT /etc/localtime && \
    AWS_ACCESS_KEY_ID=AKIAYNYEBS7YEQJ5SXFM \
    AWS_SECRET_ACCESS_KEY=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  && \
    aws s3 cp s3://nxtlbsrelease/Platform_SAAS/jpc/apache-tomcat-8.5.45.zip /tmp/apache-tomcat-8.5.45.zip && \
    mkdir -p /usr/share/tomcat8/ && \
    unzip /tmp/apache-tomcat-8.5.45.zip -d /usr/share/tomcat8/ && \
    mv /usr/share/tomcat8/apache-tomcat-8.5.45/* /usr/share/tomcat8/ && \
    rm -rf /usr/share/tomcat8/apache-tomcat-8.5.45 && \
    addgroup -S tomcat && \
    adduser -s /bin/nologin -G tomcat -h /usr/share/tomcat8 tomcat && \
    chown -R tomcat /usr/share/tomcat8 && \
    chmod +x /usr/share/tomcat8/bin/*.sh && \
    chmod -R g+r /usr/share/tomcat8/conf && \
    chown -R tomcat /usr/share/tomcat8/webapps/ /usr/share/tomcat8/work/ /usr/share/tomcat8/temp/ /usr/share/tomcat8/logs/ && \
    aws s3 cp s3://nxtlbsrelease/Platform_SAAS/jpc/PolicyControllerJava-Linux-chef-9.2.0.0-15.zip /tmp/PolicyControllerJava.zip && \
    unzip -o -q /tmp/PolicyControllerJava.zip -d /usr/local && \
    mkdir -p /usr/share/tomcat8/nextlabs && \
    aws s3 cp s3://nxtlbsrelease/Platform_SAAS/Oauth2JWTSecret_Plugin/Oauth2JWTSecret-Plugin-8.1.2.zip /tmp/Oauth2JWTSecret-Plugin.zip && \
    unzip -o -q /tmp/Oauth2JWTSecret-Plugin.zip -d /tmp/Oauth2JWTSecret-Plugin && \
    rm -rf /tmp/apache-tomcat-8.5.45.zip && \
    export CATALINA_HOME=/usr/share/tomcat8 && \
    export JRE_HOME=/usr/lib/jvm/java-1.8-openjdk && \
    chmod +x /usr/local/Policy_Controller_Java/install.sh 


# Delete extracted policy server after installation complete
# Remove installation files.
COPY jpc_properties.json /usr/local/Policy_Controller_Java/
COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

#EXPOSE 8080 58443 58080

CMD /tmp/entrypoint.sh ; sleep infinity
