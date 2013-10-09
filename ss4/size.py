#!/usr/bin/python2.7 -u
import sys
import re
#variable interpolation
sys.stdout.write("Enter a number: ".format(**locals()))
a = float(sys.stdin.readline());
if ( a < 0) : 
#variable interpolation
    sys.stdout.write("negative\n".format(**locals()))
elif (a == 0) : 
#variable interpolation
    sys.stdout.write("zero\n".format(**locals()))
elif (a < 10) : 
#variable interpolation
    sys.stdout.write("small\n".format(**locals()))
else :
#variable interpolation
    sys.stdout.write("large\n".format(**locals()))
