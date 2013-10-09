#!/usr/bin/python2.7 -u
import sys
import re

answer = 6 * 7
#variable interpolation
sys.stdout.write("{answer}\n".format(**locals()))
