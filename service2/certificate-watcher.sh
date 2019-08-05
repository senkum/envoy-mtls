#!/bin/bash

inotifywait -e close_write -m /certs |
while read -r directory events filename; do
  if [ "$filename" = "$2.crt" ] || [ "$filename" = "$3.crt" ]; then
    echo "Generating validation certificates $filename"
    /opt/generate-validation-certificate.sh $1 $2 $3 
  fi
done