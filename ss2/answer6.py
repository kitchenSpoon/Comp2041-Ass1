#!/usr/bin/python2.7 -u
import sys
import re
answer = 0
while   answer < 36  :
    answer = answer + 7
#variable interpolation
sys.stdout.write("{answer}\n".format(**locals()))
