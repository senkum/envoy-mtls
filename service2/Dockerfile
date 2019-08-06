FROM envoyproxy/envoy-alpine

RUN apk update && apk add python3 bash curl openssl inotify-tools iptables
RUN pip3 install --upgrade pip
RUN pip3 install -q Flask==0.11.1 requests==2.18.4

WORKDIR /opt/

COPY cronjob /opt/cronjob

COPY generate-certificate.sh /opt/generate-certificate.sh
RUN chmod u+x /opt/generate-certificate.sh

COPY generate-validation-certificate.sh /opt/generate-validation-certificate.sh
RUN chmod u+x /opt/generate-validation-certificate.sh

COPY certificate-watcher.sh /opt/certificate-watcher.sh
RUN chmod u+x /opt/certificate-watcher.sh

COPY service2-envoy.yaml /opt/service2-envoy.yaml

COPY service2-startup.sh /opt/service2-startup.sh
RUN chmod u+x /opt/service2-startup.sh

COPY service2.py /opt/service2.py 

ENTRYPOINT /opt/service2-startup.sh
