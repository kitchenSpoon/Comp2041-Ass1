#!/usr/bin/perl

# written by andrewt@cse.unsw.edu.au September 2013
# as a starting point for COMP2041/9041 assignment 
# http://cgi.cse.unsw.edu.au/~cs2041/13s2/assignments/perl2python

while ($line = <>) {
	if ($line =~ /^#!/ && $. == 1) {
	
		# translate #! line 
		
		print "#!/usr/bin/python2.7 -u\n";
	} elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
	
		# Blank & comment lines can be passed unchanged
		
		print $line;
	} elsif ($line =~ /^\s*print\s*"(.*)\\n"[\s;]*$/) {
		# Python's print adds a new-line character by default
		# so we need to delete it from the Perl print statement
		$string = $1;
		#if print has variable
		if($string =~ /\$/)
		{
			$string  =~ s/\$//g;
			$string =~ s/\"\\n\"$//;
			print "print $stringa";
		}
		#if print has no variable
		else
		{
			print "print \"$string\"\n";
		}
				
		
	} elsif ($line =~ /\$/) {
		
		#lines that have varibles
		$line =~ s/\$//g;
		$line =~ s/;//g;
		print "$line\n";
	
	} else {
	
		# Lines we can't translate are turned into comments
		
		print "#$line\n";
	}
}
