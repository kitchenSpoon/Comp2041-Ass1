#!/usr/bin/python2.7 -u
import sys
import re

a=1
b=0

if ( a== a and  b== b): 
#variable interpolation
        sys.stdout.write("True\n".format(**locals()))
if ( a== a or  b== a): 
#variable interpolation
	sys.stdout.write("True\n".format(**locals()))
if (not( a== b or  b== a)): 
#variable interpolation
        sys.stdout.write("True\n".format(**locals()))

