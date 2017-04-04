#!/usr/bin/python3
from xml.etree import ElementTree as Elm
from database import rec_table
from map import *
import pypyodbc
import copy
import convertors
import offices
import sys

database = 'Eris'
username = 'SA'
if sys.platform == 'linux':
    server = 'localhost'
    password = 'Sqlserver12345678'
else:
    server = 'ITS-H-NOROUZPOU\SQLEXPRESS'
    password = '123456'
driver = '{ODBC Driver 13 for SQL Server}'
con = pypyodbc.connect(
    'DRIVER='+driver+';PORT=1433;SERVER='+server+';PORT=1443;DATABASE='+database+';UID='+username+';PWD='+ password)
csr = con.cursor()
