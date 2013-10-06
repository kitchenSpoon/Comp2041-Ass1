#!/usr/bin/perl -w

#Takes an integer argument n and reads the next n lines of input and returns them as a string.
#week8 Q3

$n = shift @ARGV or die "Usage: $0 <n-lines>\n";

sub n_lines0($) {
	my ($n) = @_;
	my $text = "";
	while ($n-- > 0) {
		$text .= <>;
	}
	return $text;
}

sub n_lines1($) {
	my ($n) = @_;
	my $text = "";
	$text .= <> foreach (1..$n);
	return $text;
}	

print n_lines1($n);