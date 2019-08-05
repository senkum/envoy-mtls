#!/bin/bash

service=$1
# Generate certificate
number=`(shuf -i 1-1000 -n 1)`
echo "Generating Certificate " $service-$number

rm /certs/$service*

openssl req -new -newkey rsa:2048 -nodes -x509 -out /certs/$service.crt -keyout /certs/$service-$number.key -subj '/emailAddress=senkum@sk.com/C=US/ST=CA/L=SJ/O=SK/OU=Dev/CN='$service-$number

cat > /opt/envoy-secret-new.yaml <<EOF
version_info: "0"
resources:
- '@type': type.googleapis.com/envoy.api.v2.auth.Secret
  name: server-cert-and-key
  tls_certificate:
    certificate_chain:
      filename: /certs/$service.crt
    private_key:
      filename: /certs/$service-$number.key
EOF

mv /opt/envoy-secret-new.yaml /opt/envoy-secret.yaml