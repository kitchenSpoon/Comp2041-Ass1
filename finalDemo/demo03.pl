#!/usr/bin/perl -w
# written by andrewt@cse.unsw.edu.au as a COMP2041 example
# fetch specified web page and count the HTML tags in them

#prints tags used in a website
#week8 Q1
foreach $url (@ARGV) {
	$webpage = `wget -q -O- '$url'`;
	$webpage =~ tr/A-Z/a-z/;
    $webpage =~ s/<!--.*?-->//g; # remove comments
	@tags = $webpage =~ /<[\s\/]*(\w+)/g;
	foreach $tag (@tags) {
		$tag_count{$tag}++;
	}
}
foreach $tag (sort keys %tag_count) {
	print "$tag $tag_count{$tag}\n";
}