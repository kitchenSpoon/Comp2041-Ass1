	#!/usr/bin/perl -w
	
	number = 0
	while   number >= 0  :
#variable interpolation
	    sys.stdout.write("Enter number:\n".format(**locals()))
	    number = float(sys.stdin.readline());
	    if ( number >= 0) : 
	        if ( number % 2 == 0) : 
#variable interpolation
	            sys.stdout.write("Even\n".format(**locals()))
	        else :
#variable interpolation
	            sys.stdout.write("Odd\n".format(**locals()))
#variable interpolation
	sys.stdout.write("Bye\n".format(**locals()))
