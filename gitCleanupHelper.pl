use strict;
use warnings;

print "Input a file extension without the dot: (ex: cpp): ";
my $input = <>;
chomp($input);

open INPUT, "< gitSuperfulous.txt" or die "Can't open input file: $!";
open OUTPUT, "> gitExtra.txt" or die "Can't open output file: $!";

my $count = 0;
my $match = 0;

# reads in all lines of file one at a time
while (my $line = <INPUT>) {
	chomp $line;
	if (($line =~ /^\.\/.*/) == 1)
	{
		print "Match found: <$&>\n";
		$count++;
		print OUTPUT "rm $&; ";
	}
}

print "\nFound a total of $count files that can be cleaned.";
print "\nJust another Perl hacker...\n";

close INPUT;
close OUTPUT;