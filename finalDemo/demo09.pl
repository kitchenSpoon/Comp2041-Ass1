#!/usr/bin/perl -w
# there are perl libraries which provide a  better way to fetch web pages

#week6 Q2

foreach $url (@ARGV) {
	open F, "wget -q -O- $url|" or die;
	while ($line = <F>) {
		foreach $number (split /[^\d\- ]/, $line) {
			$number =~ s/\D//g;
			print "$number\n" if length $number >= 8 && length $number <= 15;
		}
	}
}