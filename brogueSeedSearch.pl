use strict;
use warnings;

my ($searchNo) = shift;
print "Search number is: $searchNo\n";

print "Input a criteria to search for: (ex: captive): ";
my $input = <>;
chomp($input);

open OUTPUT1, "> bestSeeds$searchNo.brs" or die "Can't open output file: $!";
open OUTPUT2, "> shortCatalog$searchNo.brs" or die "Can't open output file: $!";

open INPUT, "< c:/Program\ Files\ (x86)/Games/Brogue/Brogue seed catalog.txt" or die "Can't open input file: $!";
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

#############
# VARIABLES #
#############

# seed info
my $seed = 0;
# define depth variable to give more in depth info
my $depth = 0;
# how many instances of regex are in each seed
my $count = 0;
# define match now so we dont have to keep defining it in the loop
my $match = 0;
# hold the current seed in a string then output it to the shortCatalog if a match is found
my $seedString = "";
# where seed info will go
my %quick;

# reads in all lines of file one at a time
while (my $line = <INPUT>) 
{

	# find the line where "Seed" is written and update information
	if ($line =~ /Seed/)
	{
		$depth = 0, $count = 0; 
		$match = ($' =~ /\d+/i);
		$seed = $&;
		$seedString = "";
	}
	
	$seedString .= $line;
	
	# if this line has the keyword increment count
	$count++ if ($line =~ /$input/i && $input ne "");		
	
	# write this information to the array
	# if both search criteria are used
	if (($count > 0) && ($input ne ""))
	{
		$quick{$seed} = $count;
	}
	
	chomp ($line);
	if ($line eq "" && $count > 0)
	{
		print OUTPUT2 "$seedString";
	}
}

print OUTPUT1 "\nCriteria: '$input' " if ($input ne "");
print OUTPUT1 "\n";

# sort the dictionary by count and then print each line to file

$count = 0;
my $wrap = 5;
my $binding = "||";
foreach my $seed (sort { $quick{$a} <=> $quick{$b} or $a <=> $b } keys %quick) 
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

for (;;)
{
	print "Seed: ";
	my $input = <>;
	chomp($input);
	
	# if they input a string assume they want a random seed to be looked up
	$input = int(rand(80001)) if ( $input =~ m/[^0-9]/ );
	# break if the number is negative
	last if ($input eq "");

	open INPUT, "< c:/Program\ Files\ (x86)/Games/Brogue/Brogue seed catalog.txt" or die "Can't open input file: $!";

	# keep track of the seed number
	my $seed = 0;
	my $found = 0;
	my $output = "\n";

	# reads in all lines of file one at a time
	while (my $line = <INPUT>) {
		
		# find the line where "Seed" is written and update information
		$found = 1 if ($line =~ /Seed $input:/);
		
		# once we have found the seed add all lines to output
		$output .= $line if ($found == 1);
		
		# until we find a blank line. then we are done
		last if ($found == 1 && length($line) < 3);
	}
	
	print $output;
}

reset;

##############
# TO DO LIST #
##############
=begin

combine both programs then parse input with regex


=cut
