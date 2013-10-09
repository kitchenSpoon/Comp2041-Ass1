#!/usr/bin/python2.7 -u
import sys
import re

answer = 1 + 7 * 7 - 8
#variable interpolation
sys.stdout.write("{answer}\n".format(**locals()))
