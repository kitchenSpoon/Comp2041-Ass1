#!/usr/bin/perl -w

#subset 4
#devowel.pl

while ($line = <>) {
    chomp $line;
    $line =~ s/[aeiou]//g;
    print "$line\n";
}