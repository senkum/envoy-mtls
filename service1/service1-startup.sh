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

echo "Adding iptables"

iptables -t nat -A OUTPUT -p tcp -m tcp --dport 446 -j REDIRECT --to-ports 446


# iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-port 80
iptables-save
exec envoy -c /opt/service1-envoy.yaml --service-cluster mycluster --service-node mycluster

# export envoy_pid=`pgrep -f envoy.py`

# iptables -t nat -A OUTPUT -p tcp -j REDIRECT ! -s 127.0.0.1/32 \
#   --to-port 8082 -m owner '!' --uid-owner ${envoy_pid}

