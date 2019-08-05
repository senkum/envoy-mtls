#!/bin/bash

# Generate the certificate
/opt/generate-certificate.sh service1
/opt/generate-validation-certificate.sh service1 frontproxy service2
/opt/certificate-watcher.sh service1 frontproxy service2 &

# Start the service
python3 /opt/service1.py &

# Create crontab and start cron
# cat /opt/cronjob | crontab -
# crond

exec envoy -c /opt/service1-envoy.yaml --service-cluster mycluster --service-node mycluster 
