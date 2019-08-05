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

def invokeService2():
    r = requests.get('http://service2:8082/service2')
    return r.text

if __name__ == "__main__":
  app.run(host='127.0.0.1', port=8081, debug=True)
