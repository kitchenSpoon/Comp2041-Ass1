#!/usr/bin/python2.7 -u
import re

a="Hello"

if (bool(re.match(r'Hello', a))) : 
	print "Yes it match: ",a

if (bool(re.match(r'Hel', a))) : 
	print "Yes it does not match: ",a
