	#!/usr/bin/perl -w
	
	for arg  in sys.argv[1:]:
#variable interpolation
	    sys.stdout.write("{arg}\n".format(**locals()))
