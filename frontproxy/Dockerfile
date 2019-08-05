FROM envoyproxy/envoy-alpine

RUN apk update && apk add bash curl openssl

WORKDIR /opt/

COPY cronjob /opt/cronjob

COPY generate-certificate.sh /opt/generate-certificate.sh
RUN chmod u+x /opt/generate-certificate.sh

COPY frontproxy-envoy.yaml /opt/frontproxy-envoy.yaml

COPY frontproxy-startup.sh /opt/frontproxy-startup.sh
RUN chmod u+x /opt/frontproxy-startup.sh

ENTRYPOINT /opt/frontproxy-startup.sh
