#!/usr/local/bin/perl -w

@array = (1,2,'b');

push @array,5;

print @array,"\n";

pop @array;

print @array,"\n";

shift @array;

print @array,"\n";

unshift @array,'Hi';

print @array,"\n";

@rArray = reverse(@array);

print @rArray,"\n";
