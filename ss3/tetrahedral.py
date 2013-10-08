#!/usr/bin/python2.7 -u
import sys
import re

n = 1
while   n <= 10  :
    total = 0
    j = 1
    while   j <=  n  :
        i = 1
        while   i <=  j  :
            total = total + i
            i = i + 1
        j = j + 1
#asd
    sys.stdout.write("{total}\n".format(**locals()))
    n = n + 1
