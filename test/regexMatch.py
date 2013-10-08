#!/usr/bin/python2.7 -u
import sys
import re

a="Hello"

if (bool(re.match(r'Hello', a))) : 
#asd
	sys.stdout.write("Yes it match\n".format(**locals()))

if (bool(re.match(r'Hel', a))) : 
#asd
	sys.stdout.write("Yes it does not match\n".format(**locals()))
