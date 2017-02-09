#!/usr/bin/python
# harness.py: test harness for cookbook.py library

import mysql.connector
import cookbook

try:
    conn = cookbook.connect()
    print("Connected")
except mysql.connector.Error as e:
    print("Cannot connect to server")
    print("Error code: {}".format(e.errno))
    print("Error message:{}".format(e.msg))
else:
    conn.close()
    print("Disconnected")
