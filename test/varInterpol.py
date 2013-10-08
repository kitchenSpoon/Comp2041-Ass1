#!/usr/bin/python2.7 -u
import sys
import re

a="firstValue"
b="secondValue"
c="thirdValue"
#asd
sys.stdout.write("{a} {b} {c}\n".format(**locals()))
