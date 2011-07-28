#!/usr/bin/env python
#################################################
### TaBLeX: convert csv files into .tex files ###
#################################################
usage = """

#######################################################
TaBLeX: convert .csv tables in LaTeX-table-format files
#######################################################

It prints out the table you enter translated to LaTeX table format.

NOTE: it does not include any \\begin{tabular} or \end{tabular} so you can
customize the table in your own flavour.

Usage:
    TaBLeX.py input.csv outfile.tex N

N represents the number of columns you are translating
"""

import sys,os

class reader:
    def __init__(self,infile):
        self.infile = infile
    def readit(self):
        fo = open(self.infile,'r')
        lines = fo.readlines()
        fo.close()
        return lines

class translator:
    def __init__(self,lines):
        self.lines = lines
    def translateit(self):
        translation = []
        texlines = []
        nlines = len(self.lines)
        for i in range(nlines):
            translation.append(self.lines[i].replace(","," & "))
            texlines.append(translation[i] + " \\\ ")
        return texlines

class writer:
    def __init__(self,preamble,texlines,ending,outfile):
        self.preamble = preamble
        self.texlines = texlines
        self.ending = ending
        self.outfile = outfile
    def writeitout(self):
        nlines = len(texlines)
        fo = open(self.outfile,'w')
        fo.write(self.preamble)
        fo.close()
        fo = open(self.outfile,'a')
        for i in range(nlines):
            fo.write(texlines[i])
        fo.close()
        fo = open(self.outfile,'a')
        fo.write(self.ending)
        fo.close()

class selector:
    def __init__(self,infile):
        self.infile = infile
    def selectit(self):
        fo = open(self.infile,'r')
        lines = fo.readlines()
        fo.close()
        cols = 1 + lines[0].count(",")
        tabcols = "c"
        i = 1
        while i in range(int(cols)):
            tabcols = tabcols + " c "
            i = i + 1
        preamble = """\\begin{tabular}{ %s}
        """ % tabcols
        return preamble

### Read the command line
args = sys.argv
nargs = len(args)

infile = args[1]
outfile = args[2]

### Read the file in:
letsread = reader(infile)
lines = letsread.readit()

### Translate the infile into LaTeX format:
letstranslate = translator(lines)
texlines = letstranslate.translateit()

### Write the file out:
preambling = selector(infile)
preamble = preambling.selectit()

ending = """
\\end{tabular}"""

letswriteitout = writer(preamble,texlines,ending,outfile)
printout = letswriteitout.writeitout()









