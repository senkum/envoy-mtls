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

@app.route('/invokeService1')
def invokeService1():
  r = requests.get('http://service1:446/service1')
  return "From Service2 : " + r.text + "\n"

if __name__ == "__main__":
  app.run(host='127.0.0.1', port=8082, debug=True)
