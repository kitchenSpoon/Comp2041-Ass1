#!/usr/bin/python2.7 -u
import sys
import re

array = [1,2,'b']

array.append(5)
print "".join(map(str,array))

array.pop()

print "".join(map(str,array))

array.pop(0)
print "".join(map(str,array))

array.insert(0,'Hi')
print "".join(map(str,array))

rArray = array[::-1]
print "".join(map(str,rArray))
