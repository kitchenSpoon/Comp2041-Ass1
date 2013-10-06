#!/usr/bin/perl -w

#cut
#week6 Q1

die "Usage: $0 <n> <m> <file" if @ARGV != 3;
open F, "<$ARGV[2]" or die "$0: can not open $ARGV[2]: $!";
while ($line = <F>) {
	chomp $line;
	@chars = split //, $line;
	print @chars[$ARGV[0]-1..$ARGV[1]-1], "\n";
}