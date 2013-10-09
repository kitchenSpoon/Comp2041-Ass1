	#!/user/local/bin/perl -w 
	
	a="firstValue"
	b="secondValue"
	c="thirdValue"
#variable interpolation
	sys.stdout.write("{a} {b} {c}\n".format(**locals()))
