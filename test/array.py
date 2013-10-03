#!/usr/bin/python2.7 -u
import sys

array = [1,2,'b']

array.append(5)
print  array

array.pop()

print  array

array.pop(0)
print  array

array.insert(0,'Hi')
print  array

rArray = array[::-1]
print  rArray
