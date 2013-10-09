#!/usr/local/bin/perl

@array = split(' ',"1 2 3 4");
print @array,"\n";
$temp = join(' ',@array);
print $temp,"\n"; 

@array = split ' ',"1 2 3 4";
print @array,"\n";
$temp = join ' ',@array;
print $temp,"\n"; 

@array = split 'e',"1e2e3e4";
print @array,"\n";
$temp = join ' ',@array;
print $temp,"\n"; 

@array = split /:/,"1:2:3:4";
print @array,"\n";
$temp = join ' ',@array;
print $temp,"\n"; 