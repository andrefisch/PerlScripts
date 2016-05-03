use strict;
use warnings;

print "Input a criteria to search for: (ex: captive): ";
my $input1 = <>;
print "You may enter another search criteria:         ";
my $input2 = <>;
chomp($input1);
chomp($input2);
#my ($seedFile) = shift;

open INPUT, "< c:/Program\ Files\ (x86)/Games/Brogue/Brogue seed catalog.txt" or die "Can't open input file: $!";
open OUTPUT1, "> bestSeeds.txt" or die "Can't open output file: $!";
#open OUTPUT2, "> seedDump.txt" or die "Can't open output file: $!";

=begin

BUILDS:

STEALTH:

  Ring of Stealth
  Staff of Blinking
  Ring of Clairvoyance
  Staff of Entrancement
  Staff of Conjuration
  Staff of Poison
  War Hammer

ALLY:

  Captive
  Wand of Empowerment
  Wand of Domination
  Wand of Plenty
  Wand of Polymorphism
  Wand of Invisibility
  Staff of Protection
  Staff of Haste
  Staff of Healing
  Staff of Entrancement
  Ring of Wisdom

WIZARD:

  Staff of Firebolt
  Staff of Lightning
  Staff of Poison
  Staff of Obstruction
  Ring of Light
  Ring of Wisdom

MANEUVERABILITY:
  
  Staff of Blinking
  Staff of Tunneling
  Staff of Obstruction
  Staff of Conjuration
  Ring of Regeneration

=cut

# special searches:
# runic armor
if ($input1 =~ /runic armou?r/i)
{
	$input1 = '\+\d.*of.*\]\<\d+\>';
}
#runic weapon
elsif ($input1 =~ /runic weapon/i)
{
	$input1 = '\+\d.*of.* \<\d+\>';
}
else
{

}


if ($input2 =~ /runic armou?r/i)
{
	$input2 = '\+\d.*of.*\]\<\d+\>';
}
elsif ($input2 =~ /runic weapon/i)
{
	$input2 = '\+\d.*of.* \<\d+\>';
}
else
{

}

#############
# VARIABLES #
#############

# seed info
my $seed = 0;
# define depth variable to give more in depth info
my $depth = 0;
# how many instances of regex are in each seed
my $count1 = 0;
my $count2 = 0;
# define match now so we dont have to keep defining it in the loop
my $match = 0;

# where seed info will go
my %quick;



# reads in all lines of file one at a time
while (my $line = <INPUT>) {

	# find the line where "Seed" is written and update information
	if ($line =~ /Seed/)
	{
		$depth = 0, $count1 = 0, $count2 = 0; 
		$match = ($' =~ /\d+/i);
		$seed = $&;
	}
	
	# if this line has the keyword increment count
	$count1++ if ($line =~ /$input1/i && $input1 ne "");	
	$count2++ if ($line =~ /$input2/i && $input2 ne "");		
	
	# write this information to the array
	# if both search criteria are used
	if (($count1 > 0) && ($count2 > 0) && ($input1 ne "") && ($input2 ne ""))
	{
		$quick{$seed} = $count1 + $count2;
	}
	# otherwise only first criteria is filled
	elsif (($count1 > 0) && ($input1 ne "") && ($input2 eq ""))
	{
		$quick{$seed} = $count1;
	}
	# if only second is used for some reason
	elsif (($count2 > 0) && ($input2 ne "") && ($input1 eq ""))
	{
		$quick{$seed} = $count2;
	}
}

my $size = %quick;

print OUTPUT1 "\nCriteria: '$input1' " if ($input1 ne "");
print OUTPUT1 "and '$input2'" if ($input2 ne "");
print OUTPUT1 "\n";

# sort the dictionary by count and then print each line to file

my $count = 0;
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
		#print OUTPUT1 "   ||   ", if ($count <= $seed - $wrap);
	}
}

printf OUTPUT1 "\n\n";

reset;

##############
# TO DO LIST #
##############
=begin

Keep having script offer for them to search for another keyword in a while loop
each time we dump the output of all the seeds to a new text file which is read
in exactly the same way as the seed catalog


=cut
