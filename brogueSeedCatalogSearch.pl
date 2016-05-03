use strict;
use warnings;

my ($searchNo) = shift;
print "Search number is: $searchNo\n";

print "Input a criteria to search for: (ex: captive): ";
my $input = <>;
chomp($input);

print "Input a maximum depth to search for: (ex: 5):  ";
my $depthSearch = <>;
chomp($depthSearch);

open OUTPUT1, "> bestSeeds$searchNo.brs" or die "Can't open output file: $!";
open OUTPUT2, "> shortCatalog$searchNo.brs" or die "Can't open output file: $!";

#open INPUT, "< c:/Program\ Files\ (x86)/Games/Brogue/Brogue seed catalog.txt" or die "Can't open input file: $!";
open INPUT, "< c:/Program\ Files\ (x86)/Games/Brogue/seedCatalog.txt" or die "Can't open input file: $!";

if ($searchNo =~ /[1-9]/)
{
	# we are using the last list of seeds to search so decrement search number
	$searchNo--;
	print "Now looking in shortCatalog$searchNo.brs\n";
	open INPUT, "< shortCatalog$searchNo.brs" or die "Can't open input file: $!";	
}

=begin

=cut

####################
# SPECIAL SEARCHES #
####################

# runic armor
if ($input =~ /runic armou?r/i)
{
	$input = '\+\d.*of.*\]\<\d+\>';
}
# runic weapon
elsif ($input =~ /runic weapon/i)
{
	$input = '\+\d.*of.* \<\d+\>';
}
# stealth build
elsif ($input =~ /stealth build/i)
{
	$input = '(\+.*Stealth|Blinking|\+.*Clairv|Entrance|Conjur|Poison|\+.*Hammer)';
}
# ally build
elsif ($input =~ /ally build/i)
{
	$input = '(capti|empow|domina|wand of ple|polym|wand of inv|staff of prote|staff of ha|staff of hea|entrace|\+.*wisdom)';
}
# wizard build
elsif ($input =~ /wizard build/i)
{
	$input = '(firebolt|lightn|poison|obstr|\+.*light|\+.*wisdom)';
}
# maneuverability build
elsif ($input =~ /maneuver(ability)? build/i)
{
	$input = '(blink|tunnel|obstr|conjura|\+.*regen|\+.*clairv)';
}
##########################
# MORE SPECIFIC SEARCHES #
##########################
# gaseous potions for repiration and fire control builds
elsif ($input =~ /gas(eous)? potions?/i)
{
	$input = '(potion of caustic|potion of paralysis|potion of confusion)';
}

##############################################################
# IF THE SEARCH CONTAINS THE WORD VAULT CHANGE IT TO MACHINE # 
##############################################################
if ($input =~ /vault/i)
{
    $input =~ s/vault/machine/;
}

#############
# VARIABLES #
#############

# seed info
my $seed = 0;
# how many instances of regex are in each seed
my $count = 0;
# define match now so we dont have to keep defining it in the loop
my $match = 0;
# hold the current seed in a string then output it to the shortCatalog if a match is found
my $seedString = "";
# have we finished searching? 0 = no 1 = yes
my $done = 0;
# if the last line was blank save that information so we know when to stop
my $lastBlank = 0;
# where seed info will go
my %quick;

print "Searching for $input in all depths ";
print "up to depth $depthSearch" if (length $depthSearch > 0);
print "\n";

# reads in all lines of file one at a time
if (length $input > 0)
{
	$depthSearch = 26 if ($depthSearch eq "");
	$depthSearch++;

    # in order to search for individual machines:
    # - compare the line to previous line and next line to make sure they either don't say
    #   machine or if they do it is a different number from the machine on this line
    #
    # $twoLinesBack = $oneLineBack;
    # $oneLineBack = $line;
    #     
    #
    # if $line =~ /machine/i
    # {
    #     $twoLinesBack = $oneLineBack;
    #     $oneLineBack = $line;
    #     $consecutiveMachines++;
    # }
    # else
    # {
    #     # if the middle machine was the only one count it!
    #     if ($consecutiveMachines == 1)
    #     {
    #         $count++;
    #     }
    #     # if the third line doesn't have the word machine in it check the first two for
    #     # lack of the word door key, potion, or scroll (anything that would get you into
    #     # a machine
    #     if ($consecutiveMachines == 2)
    #     {
    #         if ($twoLinesBack !~ /(door key|potion|scroll)/i && $oneLineBack !~ /(door key|potion|scroll)/i)
    #         {
    #             $count += 2;
    #         }
    #         # if exactly one has it then increment by 1
    #         elsif ($twoLinesBack !~ /(door key|potion|scroll)/i xor $oneLineBack !~ /(door key|potion|scroll)/i)
    #         {
    #             
    #             $count += 1;
    #         }
    #         # only other possibility here is that both unlock a vault so don't count them
    #     }
    #     $consecutiveMachines = 0;
    #     $oneLineBack = "";
    #     $twoLinesBack = "";
    # }
    #
    #
    #
    #
    my $twoLinesBack = "";
    my $oneLineBack = "";
    my $singleMachineSearch = 0;
    my $consecutiveMachines = 0;
	while (my $line = <INPUT>) 
	{
	
		# find the line where "Seed" is written and update information
		if ($line =~ /Seed/i)
		{
			$done = 0, $count = 0; 
			$match = ($' =~ /\d+/i);
			$seed = $&;
			$seedString = "";
		}


		$seedString .= $line; 
		
		# if this line has the keyword and we are not done searching increment count
		$count++ if ($done == 0 && $line =~ /$input/i);

		# write this information to the array
		if (($count > 0) && ($input ne ""))
		{
			$quick{$seed} = $count;
		}
		
		# stop counting instances of $input at appropriate depth
		$done = 1 if ($line =~ /Depth.* $depthSearch/i);

		chomp ($line);
		# record entire seed if we find at least one instance of keyword
		if (length $line eq 1 && $lastBlank == 1 && $count > 0)
		{
			print OUTPUT2 "$seedString";
		}

		# reset information from last line
		$lastBlank = 0;
		# if this line is blank set $lastBlank to 1
		$lastBlank = 1 if (length $line eq 1);
	}
}
print OUTPUT1 "\nCriteria: '$input' " if ($input ne "");
print OUTPUT1 "\n";

# sort the dictionary by count and then print each line to file

$count = 0;
my $wrap = 5;
my $binding = "||";
foreach $seed (sort { $quick{$a} <=> $quick{$b} or $a <=> $b } keys %quick) 
{
	$count++;
	if ($count % $wrap == 0)
	{
		printf OUTPUT1 "%-5s %-4s %s\n", $seed, $binding, $quick{$seed} if ($quick{$seed} > 0 );
	}
	else
	{
		printf OUTPUT1 "%-5s %-4s %s\t\t", $seed, $binding, $quick{$seed} if ($quick{$seed} > 0 );
	}
}

printf OUTPUT1 "\n\n";

reset;

##############
# TO DO LIST #
##############
=begin

combine both programs then parse input with regex


=cut
