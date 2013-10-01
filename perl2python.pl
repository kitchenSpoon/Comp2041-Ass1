#!/usr/bin/perl

# written by andrewt@cse.unsw.edu.au September 2013
# as a starting point for COMP2041/9041 assignment 
# http://cgi.cse.unsw.edu.au/~cs2041/13s2/assignments/perl2python


$impSys=0;
$impFI=0;
$impRE=0;
%varTypes;
while ($line = <>) {
	if ($line =~ /.*<STDIN>.*/ or $line =~ /.*@ARGV.*/ or $line =~ /.*\$#ARGV.*/)
	{
		$impSys=1;
	}
	if ($line =~ /.*<>.*/)
	{
		$impFI=1;
	}	
	if ($line =~ m{.*s/.*/.*/.*})
	{
		$impRE=1;
	}	
	######################################################
	#varTypes
	if ($line =~ m{(\$\S*)\s*[%<>(==)]\s*\d+}) { # carefull here
		#varTypes
		$varTypes[$1]="float";


		
	}
	######################################################
	#split
	if ($line =~ m{(.*)split\((.*),(.*)\)(.*)}) {
		#split
		
		$before =$1;
		$splitFirstArg=$2;
		$splitSecondArg=$3;
		$after=$4;
		
		print $before,"\n";
		print $splitFirstArg,"\n";
		print $splitSecondArg,"\n";
		print $after,"\n";
		$line = "$before"."$splitSecondArg.split($splitFirstArg)$after";
		print $line," myline\n";

		
	}
	######################################################
	#join
	if ($line =~ m{(.*)join\((.*),(.*)\)(.*)}) {
		#join

		
		$before =$1;
		$joinFirstArg=$2;
		$joinSecondArg=$3;
		$after=$4;
		if($joinFirstArg =~ /.*@ARGV.*/)
		{
			print $1;
			$line = "$before"."$joinFirstArg."."join(sys.argv[1:])$after"; 
		}
		else
		{
			$line = "$before"."$joinFirstArg."."join($joinSecondArg)$after"; 
		}

		
	}
	######################################################
	#$#ARGV
	if ($line =~ m{.*(\$#ARGV).*}) {
		#$#ARGV
		$line =~ s/\$#ARGV/len(sys.argv) - 1/g;
		
		
	}
	if ($line =~ m{.*\$ARGV\[(\$.*)\].*}) {
		#$ARGV[]
		#print $1,"a\n";
		$line =~ s/ARGV/sys.argv/g;
		#$line =~ s/$1/$1 + 1/g; #why this no work??!!?
		$line =~ s/\[(\$.*)\]/\[$1 + 1\]/g;
		#print $1,"b\n";
		#print $line;
		
		
	}
	######################################################
	#REGEX
	if ($line =~ m{(\s*)(.*)\s*=~\s*s/(.*)/(.*)/.*\s*;\s*}) {
		#regex s///;
	
		$indent = $1;
		$var=$2;
		$toMatch=$3;
		$toReplace=$4;
		
		$line = "$indent$var = re.sub(r'$toMatch','$toReplace',$var)\n";
	}
	elsif ($line =~ m{.*(.*)\s*=~\s*/(.*)/.*}) {
		#regex //;
		$var=$1;
		$toMatch=$2;
		#need to test this case
		$line = "$var = re.match('$toMatch','$var')\n";
	}
	
	push @bunchOfLines,$line;
	
}
$lineNum=0;
foreach $line (@bunchOfLines) {
	#print $lineNum++; carefull, as we print extra lines this wont be accurate
	$lineNum++;
	if ($line =~ /^#!/ && $lineNum == 1) {
	
		# translate #! line 
		
		print "#!/usr/bin/python2.7 -u\n";
		
		if($impSys==1)
		{
			print "import sys\n";
		}
		if($impFI==1)
		{
			print "import fileinput\n";
		}
		if($impRE==1)
		{
			print "import re\n";
		}
		
	##################################################Comment
	} elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
	
		# Blank & comment lines can be passed unchanged
		
		print $line;
	#################################################################Print
	} elsif ($line =~ /^(\s*)print\s*"(.*)\\n"[\s;]*$/) {
		# need to match print with varible and strings
		# Python's print adds a new-line character by default
		# so we need to delete it from the Perl print statement
		
		#print string with newline
		$string = $2;
		$indent = $1;
		#if print has variable
		if($string =~ /\$/)
		{
			$string  =~ s/\$//g;
			#$string =~ s/\"\\n\"$//;
			print $indent,"print $string\n";
		}
		#if print has no variable
		else
		{
			print $indent,"print \"$string\"\n";
		}
		#print "First print\n";
	#################################################################Print
	} elsif ($line =~ /^(\s*)print\s*"(.*)"[\s;]*$/) {
		# need to match print with varible and strings
		# Python's print adds a new-line character by default
		# so we need to delete it from the Perl print statement
		
		#print string without newline
		$string = $2;
		$indent = $1;
		#if print has variable
		if($string =~ /\$/)
		{
			$string  =~ s/\$//g;
			#$string =~ s/\"\\n\"$//;
			print $indent,"sys.stdout.write(\"$string\")\n";
		}
		#if print has no variable
		else
		{
			print $indent,"sys.stdout.write(\"$string\")\n";
		}
		#print $indent,"sys.stdout.write($string)";
		#print "First print no nl\n";
	#################################################################Print
	} elsif ($line =~ /(\s*)print(.*)"\\n"\s*./) { 
		# need to match print with varible and strings
		# Python's print adds a new-line character by default
		# so we need to delete it from the Perl print statement
		
		#print varible , "\n";
		#ss1/answer4 , ss3/echo.2.
		$string = $2;
		$indent = $1;
		#if print has variable
		$string =~ s/,\s*$//g;
		if($string =~ /\$/)
		{
			$string  =~ s/\$//g;
			#$string =~ s/\"\\n\"$//;
			print $indent,"print $string\n";
		}
		#if print has no variable
		else
		{
			print $indent,"print $string\n"; 
		}
		#print "Second print\n";
	####################################################If
	} elsif ($line =~ /^\s*if\s*\(.*\)\s*{$/) {
		
		#if conditions if(){
		$line =~ s/eq/==/g;
		$line =~ s/[\$()]//g;
		$line =~ s/{/:/g;
		print "$line";	
		
	} elsif ($line =~ /^\s*while\s*\((.*)\s*=\s*<STDIN>\)\s*{$/) {
	
		#while conditions while($line = <STDIN>){
		$var = $1;
		$var =~ s/\$//g;
		
		print "for $var in sys.stdin:\n";
		
	} elsif ($line =~ /^\s*while\s*\((.*)\s*=\s*<>\)\s*{$/) {
	
		#while conditions while($line = <>){
		$var = $1;
		$var =~ s/\$//g;
		
		print "for $var in fileinput.input():\n";	
		
	} elsif ($line =~ /^\s*while\s*\(.*\)\s*{$/) {
		
		#while conditions while(){
		$line =~ s/eq/==/g;
		$line =~ s/[\$()]//g;
		$line =~ s/{/:/g;
		print "$line";	
		
	} elsif ($line =~ /^\s*}\s*.*{$/) {
		
		#if conditions } with something after
		$line =~ s/} //g; #with space
		$line =~ s/{/:/g;
		$line =~ s/\$//g;
		$line =~ s/elsif/elif/g;
		$line =~ s/\(//g;
		$line =~ s/\)//g;
		print $line;
		
	} elsif ($line =~ /^\s*}\s*$/) {
		
		#if conditions }
		#do nothing
		$line =~ s/}//g;
	
	} elsif ($line =~ /\s*foreach\s*(.*)\s*\((0)\.\.(.+)\)\s*{/) {
		#foreach $i(0..$#ARGV) -> xrange($#ARGV) 
		#foreach $i(0..anything) -> xrange(anything)
		$var=$1; #this has a extra space behind it WHY!!!???
		$firstNum=$2;
		$secondNum=$3;
		if ($secondNum!~/len\(sys.argv\) - 1/) # check for $#ARGV 
		{
			$secondNum++;
		}
		
		$var =~ s/\$//g;
		print "for $var in xrange($secondNum):\n";
		
		
	} elsif ($line =~ /\s*foreach\s*(.*)\s*\(([^0]+)\.\.(.+)\)\s*{/) {
		#foreach $i(2..4) -> xrange(2,4)
		$var=$1; #this has a extra space behind it WHY!!!???
		$firstNum=$2;
		$secondNum=$3;
		if ($secondNum!~/len\(sys.argv\) - 1/) # check for $#ARGV 
		{
			$secondNum++;
		}
		$var =~ s/\$//g;
		print "# $& 2\n";
		print "for $var in xrange($firstNum,$secondNum):\n";
		
	
		
	} elsif ($line =~ /\s*foreach\s*(.*)\s*\((\@ARGV)\)\s*{/) {
		#foreach $arg (@ARGV)
		$var=$1;
		$var =~ s/\$//g;
		print "for $var in sys.argv[1:]:\n";
	
	#######################################################Chomp
	} elsif ($line =~ /(\s*)chomp (.*)\s*;\s*/) {
		
		#chomp
		#$line =~ s/\$//g;
		#$line =~ s/;//g;
		$indent=$1;
		$var=$2;
		$var =~ s/\$//g;
		print "$indent$var = $var.rstrip()\n";
	
	######################################################<STDIN>
	} elsif ($line =~ /.*(\$\S*)\s*=\s*<STDIN>.*/) {
		
		#<STDIN> casting
		if($varTypes[$1] eq 'float')
		{
			#print $1,$varTypes[$1],"\n";
			$line =~ s/\$//g;
			$line =~ s/<STDIN>/float(sys.stdin.readline())/g;
		}
		else
		{
			$line =~ s/\$//g;
			$line =~ s/<STDIN>/sys.stdin.readline()/g;
		}
		print "$line";
		
	
	######################################################<STDIN>
	} elsif ($line =~ /.*<STDIN>.*/) {
		
		#<STDIN>
		$line =~ s/\$//g;
		$line =~ s/<STDIN>/sys.stdin.readline()/g;
		#$line =~ s/;//g;
		print "$line";
		
	
		
	######################################################
	} elsif ($line =~ /\$/) {
		
		#lines that have varibles
		$line =~ s/\$//g;
		$line =~ s/;//g;
		#++ --
		$line =~ s/\+\+/\+=1/g;
		$line =~ s/--/-=1/g;
		print "$line";
	
	#######################################################
	} elsif ($line =~ /(\s*)last\s*;\s*/) {
		
		#break
		#$line =~ s/\$//g;
		#$line =~ s/;//g;
		print "$1","break\n";
		
	#######################################################
	} elsif ($line =~ /(\s*)next\s*;\s*/) {
		
		#break
		#$line =~ s/\$//g;
		#$line =~ s/;//g;
		print "$1","continue\n";
	
	######################################################
	} else {
	
		# Lines we can't translate are turned into comments
		
		print "#$line\n";
	}
}
