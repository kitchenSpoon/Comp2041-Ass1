#!/usr/bin/python2.7 -u
import sys
import re

for arg  in sys.argv[1:]:
#variable interpolation
    sys.stdout.write("{arg}\n".format(**locals()))
