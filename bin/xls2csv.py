#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
File: xls2csv.py
Created: Wed 25 May 2011 08:56:06 AM EDT
Last Modified: Wed 25 May 2011 08:56:06 AM EDT
Author: Jassin MEKNASSI
Description: converts an xls file to a csv file
'''

from xlrd import open_workbook
import sys
import csv

csvwriter = csv.writer(sys.stdout)

wbk = open_workbook(sys.argv[1],encoding_override='utf-8')
sheet = wbk.sheet_by_index(0)

def encodeh(val):
    if isinstance(val,unicode):
        val = val.encode('utf-8')
        #val = val.replace('\n','')
        #val = val.replace(',','')
    return val

for rowidx in range(0,sheet.nrows):
    rowvalues = sheet.row_values(rowidx)
    rowvalues = [encodeh(r) for r in rowvalues]
    csvwriter.writerow(rowvalues)

