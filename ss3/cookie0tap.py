	#!/usr/bin/perl -w
	
	while  1  :
#variable interpolation
	    sys.stdout.write("Give me cookie\n".format(**locals()))
	    line = sys.stdin.readline();
	    line = line.rstrip()
	    if ( line=="cookie") : 
	        break
#variable interpolation
	sys.stdout.write("Thank you\n".format(**locals()))
