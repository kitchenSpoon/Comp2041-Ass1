#!/usr/bin/perl -w
# find shortest path between two towns
# djisktra
# week7 Q3

die "Usage: $0 <start> <finish>\n" if @ARGV != 2;
$start = $ARGV[0];
$finish = $ARGV[1];

while (<STDIN>) {
	/(\w+)\s+(\w+)\s+(\d+)/ || next;
	$distance{$1}{$2} = $3;
	$distance{$2}{$1} = $3;
}

$shortest_journey{$start} = 0;
$route{$start} = "";
%unprocessed_towns = %distance;
$next_town = $start;
while ($next_town && $next_town ne $finish) {
	delete $unprocessed_towns{$next_town};
	foreach  $town (keys %unprocessed_towns) {
		next if !defined $distance{$next_town}{$town};
		my $d = $shortest_journey{$next_town} + $distance{$next_town}{$town};
		next if defined $shortest_journey{$town} && $shortest_journey{$town} < $d;
		$shortest_journey{$town} = $d;
		$route{$town} = "$route{$next_town} $next_town";
	}
	my $min_distance = 1e99;   # must be larger than any possible distance
	$next_town = "";
	foreach $town (keys %unprocessed_towns) {
		next if !defined $shortest_journey{$town};
		next if $shortest_journey{$town} > $min_distance ;
		$min_distance = $shortest_journey{$town};
		$next_town = $town;
	}
}

if (!defined $shortest_journey{$finish}) {
	print "No route from $start to $finish.\n";
} else {
	print "Shortest route is length = $shortest_journey{$finish}:$route{$finish} $finish.\n";