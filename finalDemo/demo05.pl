#!/usr/bin/perl -w

#Given the name of a C function searches the C source files (*.c) in the current 
#directory for calls of the function and definitons of the function and prints 
#a message indicating the file and line number

#week8 Q4

$function = $ARGV[0] or die "Usage: $0 <function-name>\n";

foreach $c_file (glob "*.c") {
	open CF, "<$c_file" or die "$0: can not open $c_file: $!\n";
	while ($line = <CF>) {
		# remove single-line comments & strings (breaks if strings contain ")
		$line =~ s/\/\/.*//;
		$line =~ s/\/\*.*?\*\///;
		$line =~ s/".*?"//;
		# note use of \b (word boundary) to match function 
		$line =~ /\b$function\s*\(/ or next;
		print "$c_file:$. function $function ";
		# if line is indented it should a be call to the function
		if ($line =~ /^\s/) {
			print "used\n";
		} else {
			print "defined\n";
		}
	}
	close CF;
}