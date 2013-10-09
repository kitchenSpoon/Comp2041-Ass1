#!/usr/bin/perl

# written by andrewt@cse.unsw.edu.au September 2013
# as a starting point for COMP2041/9041 assignment 
# http://cgi.cse.unsw.edu.au/~cs2041/13s2/assignments/perl2python

#################################################################
#Written by Jing Wu (Jack) Lian, z3450623
#
#################################################################
#To quickly find any case use ctrl find and type hash then its name
#Example : join - "#join"
#Example : while loops - "#while"
#Example : push - "#push"
#Example : hash - "#hash"
#Example : for print you may need extra # - "####print" 

#I've used two pass through the code,
#In the first pass, my program checks for keywords such as ARGV
#and sets the flags on which modules to import, Also do some cleanup

#In the second pass I have a huge if else that checks what type
#of line it is and print them after translation

#I've use sys.stdout.write to cover the prints with and without \n

#################################################################




#flags and hashs
$impSys=0;
$impFI=0;
$impRE=0;
%varTypes;
%myDicts;
##################################################################
#		First past of the inputs
##################################################################
while ($line = <>) {
	#Check what modules i need to import
	#import sys if theres stdin and argv stuff
	if ($line =~ /.*print.*/ || $line =~ /.*<STDIN>.*/ or $line =~ /.*\@ARGV.*/ or $line =~ /.*\$#ARGV.*/) {
		$impSys=1;
	}
	#import fileinput
	if ($line =~ /.*<>.*/) {
		$impFI=1;
	}	
	#import regex if theres substitution or match
	if ($line =~ m{.*s/.*/.*/.*} || $line =~ m{.*/.*/.*}) {
		$impRE=1;
	}	
	######################################################
	#varTypes
	#varTypes is a hash use to store the type of variables, its use to figure out 
	#if we need to cast a input to number.
	if ($line =~ m{(\$\S*)\s*[%<>(==)]\s*\d+}) { # carefull here
		#varTypes
		$varTypes[$1]="float";


		
	}
	######################################################
	#! check for the ! operator and turn it into not
	if ($line =~ m{[^#"]+![^"]}) { #check ! is not the first line
		#!
		
		$line =~ s/!/not/g;

	}
	######################################################
	#|| check for || operator 
	if ($line =~ m{.*\|\|.*}) {
		#||
		
		$line =~ s/\|\|/or/g;

	}
	######################################################
	#&& check for && operator 
	if ($line =~ m{.*&&.*}) {
		#&&
		
		$line =~ s/&&/and/g;

	}
	######################################################
	#.= check for concatenation operator
	if ($line =~ m{.*\.=.*}) {
		#.=
		
		$line =~ s/\.=/+=/g;

		
	}
	######################################################
	#hash{} -> hash[]
	#hash, checks for {}, if theres {}, its a hash, nobody use %(unless in a loop)
	if ($line =~ /.*\$(\S+){(.+)}.*/) { 
		#hash
		#check if hash is initiated, if not store it into 
		#my hash of dict so that i can init it later
		if (!defined($myDicts{$1})) {
			$myDicts{$1}=1;
		}
		#if we'll accessing the hash, just turn the {} into []
		$line =~ s/{/[/g;
		$line =~ s/}/]/g;

		
	}
	######################################################
	#split non-bracket
	#match for split(stuff,stuff)
	if ($line =~ m{(.*)split\s+(.*),(.*)}) {
		#split
		
		$before =$1;
		$splitFirstArg=$2;
		$splitSecondArg=$3;
		if($splitFirstArg=~m{/.*/}) # split with regex
		{
			$splitFirstArg =~ s[/][]g;
			$line = "$before"."$splitSecondArg.split('$splitFirstArg')\n";
		}
		else #split without regex
		{
			$line = "$before"."$splitSecondArg.split($splitFirstArg)\n";
		}
		

		
	}
	######################################################
	#split with bracket
	#match for split(stuff1,stuff2)
	if ($line =~ m{(.*)split\((.*),(.*)\)(.*)}) {
		#split
		
		$before =$1;
		$splitFirstArg=$2;
		$splitSecondArg=$3;
		$after=$4;
		#"stuff2".split(stuff1)
		$line = "$before"."$splitSecondArg.split($splitFirstArg)$afters\n";

		
	}
	######################################################
	#join non-bracket
	if ($line =~ m{(.*)join\s+(.*),(.*)\s*;\s*}) {
		#join
		# i match print join --ERROR!
		
		$before =$1;
		$joinFirstArg=$2;
		$joinSecondArg=$3;
		$after=$4;
		
		#test if we're joing normal array or the array of inputs
		if($joinSecondArg =~ /.*\@ARGV.*/) {
			$line = "$before"."$joinFirstArg."."join(sys.argv[1:])$after\n"; 
		}
		else {
			$joinSecondArg =~ s/@//g;
			$line = "$before"."$joinFirstArg."."join($joinSecondArg)$after\n"; 
		}
	}
	######################################################
	#join with bracket
	if ($line =~ m{(.*)join\((.*),(.*)\)(.*)}) {
		#join
		# i match print join --ERROR!
		
		$before =$1;
		$joinFirstArg=$2;
		$joinSecondArg=$3;
		$after=$4;
		#print "3: ",$3,"\n";
		if($joinSecondArg =~ /.*\@ARGV.*/) {
			#print "hey $& \n";
			$line = "$before"."$joinFirstArg."."join(sys.argv[1:])$after\n"; 
		}
		else {
			#print "yay\n";
			$joinSecondArg =~ s/@//g;
			$line = "$before"."$joinFirstArg."."join($joinSecondArg)$after\n"; 
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
		$line =~ s/ARGV/sys.argv/g;
		#$line =~ s/$1/$1 + 1/g; #why this no work??!!?
		$line =~ s/\[(\$.*)\]/\[$1 + 1\]/g;
		
		
	}
	######################################################
	#REGEX
	if ($line =~ m{(\s*)(.*)\s*=~\s*s/(.*)/(.*)/.*\s*;\s*}) {
		#regex s///;
	    $impRE=1;
		$indent = $1;
		$var=$2;
		$toMatch=$3;
		$toReplace=$4;
		#var = re.sub(r'match','replace','source')
		$line = "$indent$var = re.sub(r'$toMatch','$toReplace',$var)\n";
		
	}
	elsif ($line =~ m{\s*.*\s*(\$[a-zA-Z0-9]+)\s*=~\s*/(.*)/.*}) {
		#regex //;
		$impRE=1;
		$var=$1;
		$toMatch=$2;
		#need to test this case
		
		#re.match(r'match','source')
		$line =~ s{\$[a-zA-Z0-9]+\s*=~\s*/.*/}{bool(re.match(r'$toMatch',$var))}g;
	}
	
	push @bunchOfLines,$line;
	
}

######################### Second Round #######################################################
######################### Second Round #######################################################
######################### Second Round #######################################################
######################### Second Round #######################################################

##################################################################
#		Second past of the inputs
##################################################################
$lineNum=0;
foreach $line (@bunchOfLines) {
	#print $lineNum++; carefull, as we print extra lines this wont be accurate
	$lineNum++;
	if ($line =~ /^#!/ && $lineNum == 1) {
	
		# translate #! line 
		
		print "#!/usr/bin/python2.7 -u\n";
		
		if($impSys==1) {
			print "import sys\n";
		}
		if($impFI==1) {
			print "import fileinput\n";
		}
		if($impRE==1) {
			print "import re\n";
		}
		#init hash
		foreach (keys %myDicts) {
			print "$_ = {}\n";
		}
		
	##################################################Comment
	} elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
	
		# Blank & comment lines can be passed unchanged
		
		print $line;
	#################################################################Print
	} elsif ($line =~ /(\s*)printf\s+"(.*)"\s*,\s*(.*)\s*;\s*/) {
	
		#printf 
		$string=$2;
		$var=$3;
		$string =~ s/\\n//g;
		$line = "$1"."print \"$string\" % $var \n";
		$line =~ s/\$//g;
		print $line;
	#################################################################Print
	} elsif ($line =~ /(\s*)print\s+"(.*)"\s*;\s*/ && $line !~ /.*ARGV.*/i) {
	
		#print variable interpolation
		$indent=$1;
		$toBePrinted=$2;
		$var = $2;
		$var =~ s/.*\$([a-zA-Z0-9_]+).*/$1/g;
		$toBePrinted =~ s/\$([a-zA-Z0-9_]+)/{$1}/g;
		$line = "$indent"."sys.stdout.write(\"$toBePrinted\".format(**locals()))\n";
		print "#variable interpolation\n";
		print $line;
	
	#################################################################Print
	} elsif ($line =~ /(\s*)print\s+@([a-zA-Z0-9]+)\s*,*.*\s*;/) {
	
		#print Array
		print "$1"."print \"\".join(map(str,$2))\n";
	
	#################################################################Print
	} elsif ($line =~ /^(\s*)print\s*"(.*)\\n"[\s;]*$/) {
		# need to match print with varible and strings
		# Python's print adds a new-line character by default
		# so we need to delete it from the Perl print statement
		
		#print string with newline
		$string = $2;
		$indent = $1;
		#if print has variable
		if($string =~ /\$/) {
			$string  =~ s/\$//g;
			#$string =~ s/\"\\n\"$//;
			print $indent,"print $string\n";
		}
		#if print has no variable
		else {
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
		#if print has variable or array
		if($string =~ /\$/ || $string =~ /@/) {
			$string  =~ s/\$//g;
			$string  =~ s/@//g;
			#$string =~ s/\"\\n\"$//;
			print $indent,"sys.stdout.write(\"$string\")\n";
		}
		#if print has no variable
		else {
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
		if($string =~ /\$/ || $string =~ /@/) {
			$string =~ s/\$//g;
			$string =~ s/@//g;
			#$string =~ s/\"\\n\"$//;
			print $indent,"print $string\n";
		}
		#if print has no variable
		else {
			print $indent,"print $string\n"; 
		}
		#print "Second print\n";
	####################################################If
	} elsif ($line =~ /^\s*if\s*\(.*\)\s*{$/) {
		
		#if conditions if(){
		$line =~ s/\s+eq\s+/==/g;
		$line =~ s/\s+ne\s+/!=/g;
		$line =~ s/if\s*(.*)/if $1 /g; # to prevent removing () of functions in if
		$line =~ s/[\$]/ /g;
		$line =~ s/{/:/g;
		print "$line";	
		
	} elsif ($line =~ /^(\s*)while\s*\((.*)\s*=\s*<STDIN>\)\s*{$/) {
	
		#while conditions while($line = <STDIN>){
		$indent = $1;
		$var = $2;
		$var =~ s/\$//g;
		
		print "$indent"."for $var in sys.stdin:\n";
		
	} elsif ($line =~ /^(\s*)while\s*\((.*)\s*=\s*<>\)\s*{$/) {
	
		#while conditions while($line = <>){
		$indent = $1;
		$var = $2;
		$var =~ s/\$//g;
		
		print "$indent"."for $var in fileinput.input():\n";	
		
	} elsif ($line =~ /^\s*while\s*\(.*\)\s*{$/) {
		
		#while conditions while(){
		$line =~ s/\s+eq\s+/==/g;
		$line =~ s/\s+ne\s+/!=/g;
		$line =~ s/[\$()]/ /g;
		$line =~ s/{/:/g;
		print "$line";	
		
	} elsif ($line =~ /^\s*}\s*.*{$/) {
		
		#if conditions } with something after
		$line =~ s/\s+eq\s+/==/g;
		$line =~ s/\s+ne\s+/!=/g;
		$line =~ s/} //g; #with space
		$line =~ s/{/:/g;
		$line =~ s/\$//g;
		$line =~ s/elsif/elif/g;
		$line =~ s/if\s*(.*)/if $1 /g; # to prevent removing () of functions in if
		print $line;
		
	} elsif ($line =~ /^\s*}\s*$/) {
		
		#if conditions }
		#do nothing
		$line =~ s/}//g;
	#} elsif ($line =~ /(\s*)for\s*\((.*);(.*);(.*)\)\s*{/) {
	#	#C style for loop
	#	$indent=$1;
	#	$init=$2;
	#	$condition=$3;
	#	$todo=$4;
	#	#print "asdasdasdsadas\n\n";
	#	
	#	$init =~ s/\$//g;
	#	$condition =~ s/\$//g;
	#	$todo =~ s/\$//g;
	#	$todo =~ s/\+\+/+=1/g;
	#	$todo =~ s/--/-=1/g;
	#	print "$indent"."$init\n";
	#	print "$indent"."while($condition):\n";
	#	print "$indent"."   "."$todo\n";
		
		
	} elsif ($line =~ /(\s*)foreach\s*(.*)\s*\((0)\.\.(.+)\)\s*{/) {
		#foreach $i(0..$#ARGV) -> xrange($#ARGV) 
		#foreach $i(0..anything) -> xrange(anything)
		$indent=$1;
		$var=$2; #this has a extra space behind it WHY!!!???
		$firstNum=$3;
		$secondNum=$4;
		if ($secondNum!~/len\(sys.argv\) - 1/) { # check for $#ARGV
			$secondNum++;
		}
		
		$var =~ s/\$//g;
		print "$indent"."for $var in xrange($secondNum):\n";
		
		
	} elsif ($line =~ /(\s*)foreach\s*(.*)\s*\(([^0]+)\.\.(.+)\)\s*{/) {
		#foreach $i(2..4) -> xrange(2,4)
		$indent=$1;
		$var=$2; #this has a extra space behind it WHY!!!???
		$firstNum=$3;
		$secondNum=$4;
		if ($secondNum!~/len\(sys.argv\) - 1/) {# check for $#ARGV  
			$secondNum++;
		}
		$var =~ s/\$//g;
		print "$indent"."for $var in xrange($firstNum,$secondNum):\n";
		
	
		
	} elsif ($line =~ /(\s*)foreach\s*(.*)\s*\((\@ARGV)\)\s*{/) {
		#foreach $arg (@ARGV)
		$indent=$1;
		$var=$2;
		$var =~ s/\$//g;
		print "$indent"."for $var in sys.argv[1:]:\n";
	
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
		if($varTypes[$1] eq 'float') {
			#print $1,$varTypes[$1],"\n";
			$line =~ s/\$//g;
			$line =~ s/<STDIN>/float(sys.stdin.readline())/g;
		}
		else {
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
	} elsif ($line =~ /unshift\s+@(.*),(.*)\s*;/) {
		
		#unshift
		$line = "$1.insert(0,$2)";
		print $line;
	######################################################
	} elsif ($line =~ /\bshift\s+@(.*)\s*;/) {
		
		#shift
		$line = "$1.pop(0)";
		print $line;
		
	######################################################
	} elsif ($line =~ /push\s+@(.*),(.*)\s*;/) {
		
		#push
		$line = "$1.append($2)";
		print $line;
		
	######################################################
	} elsif ($line =~ /pop\s+@(.*)\s*;/) {
		
		#pop
		$line = "$1.pop()";
		print $line,"\n";
		
	######################################################
	} elsif ($line =~ /\s*open\s\(\s*(.*)\s*,\s*(.*)\s*\)/) {
		
		#open
		$handler=$1;
		$file=$2;
		$file =~ s/"//g;
		$line = "$handler = open(\"$file\",'r')";
		print $line,"\n";
	
	######################################################
	} elsif ($line =~ /(.*@\S+\s*=\s*)(.*)\((.*)\)/) {
		
		#lines that have array assignment
		$function=$2;
		$before=$1;
		$infunction=$3;
		#reverse array
		if ($function =~ /reverse/)
		{
			$line = "$before"."$infunction"."[::-1]";
		}
		
		$line =~ s/\@//g;
		$line =~ s/;//g;
		$line =~ s/([^a-zA-Z0-9])\((.*)\)/$1\[$2\]/g; #will not turn function() into function[]#
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
