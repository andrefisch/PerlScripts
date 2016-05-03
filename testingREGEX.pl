use strict;
use warnings;

my$string = ',abc,bcad,def,bcd,';
my $match = ($string =~ s/([^,]+)\b(.*),(\1[^,]+)/$3$2/);

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


