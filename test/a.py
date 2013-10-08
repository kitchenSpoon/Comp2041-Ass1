#!/usr/bin/python2.7 -u
import sys
import re

a="firstValue"
b="secondValue"
c="thirdValue"
sys.stdout.write("{a} {b} {c}\n".format(**locals()))
