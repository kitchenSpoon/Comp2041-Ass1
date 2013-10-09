	#!/usr/bin/perl -w
	
	answer = 42
#variable interpolation
	sys.stdout.write("{answer}\n".format(**locals()))
