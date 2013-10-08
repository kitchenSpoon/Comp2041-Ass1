#!/usr/local/bin/perl -w

$text = "Hello How are you?";
print $text,"\n";

$text =~ s/[aeiou]//g;
print $text,"\n";

