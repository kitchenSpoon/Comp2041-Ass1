	#!/usr/bin/perl -w
	
	answer = 41
	if ( answer > 0) : 
	    answer = answer + 2
	if ( answer == 43) : 
	    answer = answer - 1
#variable interpolation
	sys.stdout.write("{answer}\n".format(**locals()))
