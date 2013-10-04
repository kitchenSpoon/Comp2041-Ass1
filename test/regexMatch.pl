#!/usr/local/bin/perl -w

$a="Hello"

if($a =~ /Hello/) {
	print "Yes it match: ",$a;
}

if($a =~ /Hel/) {
	print "Yes it does not match: ",$a;
}
