FROM alpine:3.7
LABEL Maintainer="Nextlabs"

ARG HOSTNAME=${HOSTNAME}

RUN apk update && \
    apk add unzip && \
    apk add bash && \
    apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip &&\
    ln -sf /usr/share/zoneinfo/PST8PDT /etc/localtime && \
    AWS_ACCESS_KEY_ID=AKIAYNYEBS7YEQJ5SXFM \
    AWS_SECRET_ACCESS_KEY=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  && \
    aws s3 cp s3://nxtlbsrelease/Platform_SAAS/cc/icenet.zip /tmp/icenet.zip && \
    mkdir -p /opt/nextlabs/ && \
    unzip /tmp/icenet.zip -d /opt/nextlabs/ && \
    rm -rf /tmp/icenet.zip

# Delete extracted policy server after installation complete
# Remove installation files.
COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

#EXPOSE 8080 58443 58080

CMD /tmp/entrypoint.sh ; sleep infinity
