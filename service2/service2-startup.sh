#!/bin/bash

# Generate the certificate
/opt/generate-certificate.sh service2
/opt/generate-validation-certificate.sh service2 frontproxy service1
/opt/certificate-watcher.sh service2 frontproxy service1 &

# Start the service
python3 /opt/service2.py &

# Create crontab and start cron
# cat /opt/cronjob | crontab -
# crond

echo "Adding iptables"
iptables -t nat -A OUTPUT -p tcp -m tcp --dport 446 -j REDIRECT --to-ports 446
iptables-save

echo "Starting envoy"
exec envoy -c /opt/service2-envoy.yaml --service-cluster mycluster --service-node mycluster # --log-level debug
