#!/usr/bin/python2.7 -u
import sys
import re

text = "Hello How are you?"
print  text

text  = re.sub(r'[aeiou]','',text )
print  text

