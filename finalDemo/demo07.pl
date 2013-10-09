#!/usr/bin/perl -w

#Prints a table of multiplications
#week8 Q8

die "Usage $0 <n> <m> <column-width>" if @ARGV != 3;
$n = $ARGV[0];
$m = $ARGV[1];
$width = $ARGV[2];
foreach $x (1..$n) {
	printf "%${width}d", $x;
    foreach $y (1..$m) {
        printf "%${width}d", $x*$y;
    }
    print "\n";
}