	#!/usr/bin/perl -w
	
	x = 1
	while   x <= 10  :
#variable interpolation
	    sys.stdout.write("{x}\n".format(**locals()))
	    x = x + 1
