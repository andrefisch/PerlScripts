use strict;
use warnings;


my $match = ($line =~ /^<tile gid="(\d*)"\/>$/);

if ($match == 1)
{
	$line =~ s/(\d+)/$1 + 1/e;
}	

print $line;
