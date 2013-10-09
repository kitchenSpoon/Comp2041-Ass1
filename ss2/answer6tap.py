	#!/usr/bin/perl -w
	answer = 0
	while   answer < 36  :
	    answer = answer + 7
#variable interpolation
	sys.stdout.write("{answer}\n".format(**locals()))
