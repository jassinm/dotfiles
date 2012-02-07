#!/usr/bin/env python
from clint import args
import ibm_db
import json


groups = args.grouped
nodename = groups['-nodename'][0]
user = groups['-user'][0]
pwd = groups['-pwd'][0]
query = groups['-query'][0]
outputfile = groups['-ofile'][0]


ibm_db_conn = ibm_db.connect(nodename, user, pwd,
                  {ibm_db.ATTR_CASE: ibm_db.CASE_LOWER})
sql = query
stmt = ibm_db.exec_immediate(ibm_db_conn, sql)
result = ibm_db.fetch_assoc(stmt)
out = []
counter = 0
while(result):
    out.append(result)
    counter += 1
    if counter % 10000 == 0:
        print counter
    result = ibm_db.fetch_assoc(stmt)

ofile = open(outputfile, 'w')
ofile.write(json.dumps(out, indent=4))
ofile.close()
