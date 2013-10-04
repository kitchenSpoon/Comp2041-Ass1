#!/usr/local/bin/perl -w

$a="Hello";

if($a =~ /Hello/) {
	print "Yes it match\n";
}

if($a =~ /Hel/) {
	print "Yes it does not match\n";
}
