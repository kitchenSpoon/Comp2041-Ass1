#!/usr/bin/perl -w
# delete blank lines from specified files
#week8 Q9

die "Usage: $0 <files>\n" if !@ARGV;

foreach $file (@ARGV) {
	open(IN, "$file") || die("Can not open $file: $!");
	@lines = <IN>;  # reads entire file into array
	close(IN);
	open(OUT, ">$file") || die("Can not open $file: $!");
	foreach $line (@lines) {    
		print OUT $line if $line !~ /^\s*$/;
	}
	close(OUT);