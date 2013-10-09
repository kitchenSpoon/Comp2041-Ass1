	#!/usr/bin/perl -w
	
	for line  in fileinput.input():
	    line = line.rstrip()
	    line  = re.sub(r'[aeiou]','',line )
#variable interpolation
	    sys.stdout.write("{line}\n".format(**locals()))
