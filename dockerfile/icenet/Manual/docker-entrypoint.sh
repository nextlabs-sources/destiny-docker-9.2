#!/bin/bash
set -e
#/etc/init.d/CompliantEnterpriseServer "$@"
# echo cc > /etc/hostname - Pass when running container

# License
# /opt/nextlabs/PolicyServer/java/bin/java -jar /opt/nextlabs/PolicyServer/tools/crypt/crypt.jar -w '{"license_info":{"expiry_date":"05/11/2020","subcription_mode":"trial"},"pdp_info":[{"id":1,"host":"poc-jpc0","memory":"2048MB","vcpu":1},{"id":2,"host":"poc-jpc1","memory":"2048MB","vcpu":1}]}' > /opt/nextlabs/PolicyServer/server/license/sys_info.dat

# fix to avoid port conflict 
cp  /opt/Nextlabs/PolicyServer/java/jre/lib/rt.jar  /opt/Nextlabs/PolicyServer/java/jre/lib/rt.jar-bak
find /opt/Nextlabs/PolicyServer/java/jre/lib/rt.jar -type f -exec sed -i 's/8889/7779/g' {} \;

# Copy CC certs from below direcroty to ICENET cert directory
yes | cp -rf /tmp/cc-certs/* /opt/Nextlabs/PolicyServer/server/certificates/

cd /opt/Nextlabs/PolicyServer/server/certificates
chown nextlabs:nextlabs *

# remove license key
rm /usr/local/license.dat
