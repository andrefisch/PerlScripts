use strict;
use warnings;

my $string = 'Ba(1)Cl(2)H(2)SO4(1)';
my $match = ($string =~ s/(\w+\(\d+\))(\w+\(\d+\))(\w+\(\d+\))(\w+\(\d+\))/$3$2$1$4/);

if ($match == 1)
{
	print "Matched: <$&>\n";
	print "$string\n";
}
else
{
	print "No Match\n"
}

reset;

#\w+\(\d+\)\w+\(\d+\)\w+\(\d+\)\w+\(\d+\)
