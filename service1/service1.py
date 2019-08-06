from flask import Flask
from flask import request
import os
import requests
import socket
import sys

app = Flask(__name__)

@app.route('/service1')
def service1():
  return ('Service1 called\n')

@app.route('/invokeService2')
def invokeService2():
  validationFile = ""
  for filename in os.listdir("/certs"):
    root, ext = os.path.splitext(filename)
    if root.startswith('service1-validation') and ext == '.crt':
      validationFile = filename
  print(validationFile)
  r = requests.get('http://service2:446/service2')
  return "From Service1 " + r.text

if __name__ == "__main__":
  app.run(host='127.0.0.1', port=8081, debug=True)
