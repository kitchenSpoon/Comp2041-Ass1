#!/usr/bin/python2.7 -u
import sys
import re
factor0 = 6
factor1 = 7
answer = factor0 * factor1
#variable interpolation
sys.stdout.write("{answer}\n".format(**locals()))
