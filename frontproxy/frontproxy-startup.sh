#!/bin/bash

# Generate the certificate
/opt/generate-certificate.sh frontproxy

# Create crontab and start cron
# cat /opt/cronjob | crontab -
# crond

exec envoy -c /opt/frontproxy-envoy.yaml --service-cluster mycluster --service-node mycluster #--log-level debug
