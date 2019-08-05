cat /certs/$2.crt /certs/$3.crt > /certs/$1-validation.crt
cat > /opt/envoy-validation-secret-new.yaml <<EOF
version_info: "0"
resources:
- '@type': type.googleapis.com/envoy.api.v2.auth.Secret
  name: validation-certs
  validation_context:
    trusted_ca:
      filename: /certs/$1-validation.crt
EOF
mv /opt/envoy-validation-secret-new.yaml /opt/envoy-validation-secret.yaml