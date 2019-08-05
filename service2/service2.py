from flask import Flask
from flask import request
import os
import requests
import socket
import sys

app = Flask(__name__)

@app.route('/service2')
def service2():
  return ('Service2 called\n')

def invokeService1():
    r = requests.get('http://localhost:8081/service1')
    return r.text

if __name__ == "__main__":
  app.run(host='127.0.0.1', port=8082, debug=True)
