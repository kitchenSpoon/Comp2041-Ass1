#!/usr/bin/python2.7 -u
import sys
import re
#asd
sys.stdout.write("Enter a number: ".format(**locals()))
a = float(sys.stdin.readline());
if ( a < 0) : 
#asd
    sys.stdout.write("negative\n".format(**locals()))
elif (a == 0) : 
#asd
    sys.stdout.write("zero\n".format(**locals()))
elif (a < 10) : 
#asd
    sys.stdout.write("small\n".format(**locals()))
else :
#asd
    sys.stdout.write("large\n".format(**locals()))
