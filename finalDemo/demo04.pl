#!/usr/bin/perl -w

#subset4
#odd0.pl

$number = 0;
while ($number >= 0) {
    print "Enter number:\n";
    $number = <STDIN>;
    if ($number >= 0) {
        if ($number % 2 == 0) {
            print "Even\n";
        } else {
            print "Odd\n";
        }
    }
}
print "Bye\n";