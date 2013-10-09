#!/usr/bin/python2.7 -u
import sys
import re

answer = 42
#variable interpolation
sys.stdout.write("{answer}\n".format(**locals()))
