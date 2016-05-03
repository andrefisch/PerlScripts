use strict;
use warnings;

print "Which seed would you like to look up?\n";
print "You may also choose random or 0 to quit.\n";

for (;;)
{
	print "Seed: ";
	my $input = <>;
	chomp($input);
	
	# if they input a string assume they want a random seed to be looked up
	$input = int(rand(80001)) if ( $input =~ m/[^0-9]/ );
	# break if the number is negative
	last if ($input <= 0);

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