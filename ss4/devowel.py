#!/usr/bin/python2.7 -u
import sys
import fileinput
import re

for line  in fileinput.input():
    line = line.rstrip()
    line  = re.sub(r'[aeiou]','',line )
#variable interpolation
    sys.stdout.write("{line}\n".format(**locals()))
