#!/usr/bin/python2.7 -u
import sys
import re

number = 0
while   number >= 0  :
#asd
    sys.stdout.write("Enter number:\n".format(**locals()))
    number = float(sys.stdin.readline());
    if ( number >= 0) : 
        if ( number % 2 == 0) : 
#asd
            sys.stdout.write("Even\n".format(**locals()))
        else :
#asd
            sys.stdout.write("Odd\n".format(**locals()))
#asd
sys.stdout.write("Bye\n".format(**locals()))
