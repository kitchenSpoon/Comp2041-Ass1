#!/usr/local/bin/perl -w

foreach my $f(glob("ss0/*.pl"))
{
	$pyF=$f;
	$pyF=~s/\.pl/.py/g;
	print $f," ",$pyF,"\n";
	$output=`perl $f`;
	`perl perl2python.pl $f > $pyF`;
	$expectOutput=`python $pyF`;
	print $output, $expectOutput;
	
}
print "End of Subset 0\n\n";
foreach my $f(glob("ss1/*.pl"))
{
	$pyF=$f;
	$pyF=~s/\.pl/.py/g;
	print $f," ",$pyF,"\n";
	$output=`perl $f`;
	`perl perl2python.pl $f > $pyF`;
	$expectOutput=`python $pyF`;
	print $output, $expectOutput;
}
print "End of Subset 1\n\n";
foreach my $f(glob("ss2/*.pl"))
{
	$pyF=$f;
	$pyF=~s/\.pl/.py/g;
	print $f," ",$pyF,"\n";
	$output=`perl $f`;
	`perl perl2python.pl $f > $pyF`;
	$expectOutput=`python $pyF`;
	print $output, $expectOutput;
	
}
print "End of Subset 2\n\n";
foreach my $f(glob("ss3/*.pl"))
{
	$pyF=$f;
	$pyF=~s/\.pl/.py/g;
	print $f," ",$pyF,"\n";
	`perl perl2python.pl $f > $pyF`;
	if($f=~/cookie0\.pl/ || $f=~/cookie0tap\.pl/)
	{
		$output=`perl $f < ss3/cookie0.input`;
		$expectOutput=`python $pyF < ss3/cookie0.input`;
	}
	elsif($f=~/echo\.2\.pl/ || $f=~/echo\.2tap\.pl/)
	{
		$output=`perl $f Hi 1 3 5 Bye`;
		$expectOutput=`python $pyF Hi 1 3 5 Bye`;
	}
	elsif($f=~/echonl\.0\.pl/ || $f=~/echonl\.0tap\.pl/)
	{
		$output=`perl $f testing1 testing2`;
		$expectOutput=`python $pyF testing1 testing2`;
	}
	else{
		$output=`perl $f`;
		$expectOutput=`python $pyF`;
	}
	
	print $output, $expectOutput;
	
}
print "End of Subset 3\n\n";
foreach my $f(glob("test/*.pl"))
{
	$pyF=$f;
	$pyF=~s/\.pl/.py/g;
	print $f," ",$pyF,"\n";
	`perl perl2python.pl $f > $pyF`;
	if($f=~/cookie0\.pl/ || $f=~/cookie0tap\.pl/)
	{
		$output=`perl $f < ss3/cookie0.input`;
		$expectOutput=`python $pyF < ss3/cookie0.input`;
	}
	else{
		$output=`perl $f`;
		$expectOutput=`python $pyF`;
	}
	
	
	print $output, $expectOutput;
	
}
print "End of Test\n\n";
foreach my $f(glob("ss4/*.pl"))
{
	$pyF=$f;
	$pyF=~s/\.pl/.py/g;
	print $f," ",$pyF,"\n";
	`perl perl2python.pl $f > $pyF`;
	if($f=~/devowel\.pl/ || $f=~/devoweltap\.pl/)
	{
		$output=`perl $f < ss4/devowel.arguments`;
		$expectOutput=`python $pyF < ss4/devowel.arguments`;
	}
	elsif($f=~/echonl\.1\.pl/ || $f=~/echonl\.1tap\.pl/)
	{
		$output=`perl $f Hi 1 2 3 4 Bye`;
		$expectOutput=`python $pyF Hi 1 2 3 4 Bye`;
	}
	elsif($f=~/line_count\.1\.pl/ || $f=~/line_count\.1tap\.pl/)
	{
		$output=`perl $f < ss4/line_count.1.input`;
		$expectOutput=`python $pyF < ss4/line_count.1.input`;
	}
	elsif($f=~/odd0\.pl/ || $f=~/odd0tap\.pl/)
	{
		$output=`perl $f `;
		$expectOutput=`python $pyF `;
	}
	else{
		$output=`perl $f`;
		$expectOutput=`python $pyF`;
	}
	print $output, $expectOutput;
	
}
print "End of Subset 4\n\n";
