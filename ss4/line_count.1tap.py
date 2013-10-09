	#!/usr/bin/perl -w
	# written by andrewt@cse.unsw.edu.au as a COMP2041 lecture example
	# Count the number of lines on standard input.
	
	line = ""
	line_count = 0
	for line  in sys.stdin:
	    line_count+=1
#variable interpolation
	sys.stdout.write("{line_count} lines\n".format(**locals()))
