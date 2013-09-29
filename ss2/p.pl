#!/usr/bin/perl

# written by andrewt@cse.unsw.edu.au September 2013
# as a starting point for COMP2041/9041 assignment 
# http://cgi.cse.unsw.edu.au/~cs2041/13s2/assignments/perl2python

while ($line = <>) {
	if ($line =~ /^#!/ && $. == 1) {
	
		# translate #! line 
		
		print "#!/usr/bin/python2.7 -u\n";
	##################################################
	} elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
	
		# Blank & comment lines can be passed unchanged
		
		print $line;
	#################################################################
	} elsif ($line =~ /^(\s*)print\s*"(.*)\\n"[\s;]*$/) {#need to match print with varible and strings
		# Python's print adds a new-line character by default
		# so we need to delete it from the Perl print statement
		$string = $2;
		$indent = $1;
		#if print has variable
		if($string =~ /\$/)
		{
			$string  =~ s/\$//g;
			#$string =~ s/\"\\n\"$//;
			print $indent,"print $string\n";
		}
		#if print has no variable
		else
		{
			print $indent,"print \"$string\"\n";
		}
	
	####################################################
	} elsif ($line =~ /^\s*if\s*\(.*\)\s*{$/) {
		
		#if conditions if(){
		$line =~ s/[\$()]//g;
		$line =~ s/{/:/g;
		print "$line";	
	} elsif ($line =~ /^\s*while\s*\(.*\)\s*{$/) {
		
		#if conditions if(){
		$line =~ s/[\$()]//g;
		$line =~ s/{/:/g;
		print "$line";	
		
	} elsif ($line =~ /^\s*}\s*$/) {
		
		#if conditions }
		#do nothing
		$line =~ s/}//g;
	######################################################
	} elsif ($line =~ /\$/) {
		
		#lines that have varibles
		$line =~ s/\$//g;
		$line =~ s/;//g;
		print "$line";
	#######################################################
	} elsif ($line =~ /\s*last\s*;\s*/) {
		
		#break
		#$line =~ s/\$//g;
		#$line =~ s/;//g;
		print "break";
	
	######################################################
	} else {
	
		# Lines we can't translate are turned into comments
		
		print "#$line\n";
	}
}
