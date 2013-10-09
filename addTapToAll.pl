#!/usr/local/bin/perl -w

foreach my $f(glob("ss0/*.pl"))
{
	$tapF=$f;
	$tapF=~s/(.*)\.pl/$1tap.pl/g;
	`perl addTap.pl $f > $tapF`;
	
	
}
print "End of Subset 0\n\n";
foreach my $f(glob("ss1/*.pl"))
{
	$tapF=$f;
	$tapF=~s/(.*)\.pl/$1tap.pl/g;
	`perl addTap.pl $f > $tapF`;
}
print "End of Subset 1\n\n";
foreach my $f(glob("ss2/*.pl"))
{
	$tapF=$f;
	$tapF=~s/(.*)\.pl/$1tap.pl/g;
	`perl addTap.pl $f > $tapF`;
	
}
print "End of Subset 2\n\n";
foreach my $f(glob("ss3/*.pl"))
{
	$tapF=$f;
	$tapF=~s/(.*)\.pl/$1tap.pl/g;
	`perl addTap.pl $f > $tapF`;
	
}
print "End of Subset 3\n\n";
foreach my $f(glob("test/*.pl"))
{
	$tapF=$f;
	$tapF=~s/(.*)\.pl/$1tap.pl/g;
	`perl addTap.pl $f > $tapF`;
	
}
print "End of Test\n\n";
foreach my $f(glob("ss4/*.pl"))
{
	$tapF=$f;
	$tapF=~s/(.*)\.pl/$1tap.pl/g;
	`perl addTap.pl $f > $tapF`;
	
}
print "End of Subset 4\n\n";
