	#!/usr/bin/perl -w
	
	answer = 1 + 7 * 7 - 8
#variable interpolation
	sys.stdout.write("{answer}\n".format(**locals()))
