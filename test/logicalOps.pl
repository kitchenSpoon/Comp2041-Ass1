#!/usr/local/bin/perl -w

$a=1;
$b=0;

if($a==$a && $b==$b){
        print "True\n";
}
if($a==$a || $b==$a){
	print "True\n";
}
if(!($a==$b || $b==$a)){
        print "True\n";
}

