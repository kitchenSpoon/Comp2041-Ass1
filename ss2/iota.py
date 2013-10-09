#!/usr/bin/python2.7 -u
import sys
import re

x = 1
while   x <= 10  :
#variable interpolation
    sys.stdout.write("{x}\n".format(**locals()))
    x = x + 1
