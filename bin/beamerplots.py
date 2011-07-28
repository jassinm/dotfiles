#!/usr/bin/env python
'''
File: beamerplots
Created: Wed 27 Jul 2011 09:31:59 AM EDT
Last Modified: Wed 27 Jul 2011 02:39:37 PM EDT
Author: Jassin MEKNASSI
Description:
'''
import os
import sys

def createbeamerstm(pltfile):

    bname = os.path.basename(pltfile)

    print '\\begin{frame}'
    print '\\frametitle{}'
    print '\\begin{minipage}[t]{0.95\\textwidth}'
    print '\\begin{figure}'
    print '\\centering'
    print '\\includegraphics[width=0.8\\textwidth]{%s}' %bname
    print '\\end{figure}'
    print '\\end{minipage}'
    print '\\end{frame}'


def main():
    filestorun = sys.argv[1:]
    for fr in filestorun:
        createbeamerstm(fr)
        print '\n\n'
if __name__ == '__main__':
    status = main()
    sys.exit(status)
