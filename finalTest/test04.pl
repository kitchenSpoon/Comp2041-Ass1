#!/usr/local/bin/perl

@array = split(' ',"1 2 3 4");
print @array,"\n";
$temp = join(' ',@array);
print $temp,"\n"; 
print join(' ',split(' ',"Hi Weee Yay")),"\n";
