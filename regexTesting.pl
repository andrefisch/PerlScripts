use strict;
use warnings;

my $string = '"When the walls came down"';
my $match = ($string =~ tr/"//d);
print "$string\n";

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
