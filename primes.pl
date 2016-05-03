use strict;
use warnings;

# Accept a number from the user
print "maximum: ";
my $maximum = <STDIN>;

# Make an array of numbers
my @numbers = (2..$maximum);

# Iterate through that array
while (my $prime = shift @numbers) 
{
    # Print the next prime
    print "$prime\n";
    # Remove multiples of that prime
    @numbers = grep {$_ % $prime} @numbers;
}