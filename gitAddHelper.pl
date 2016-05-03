use strict;
use warnings;

print "Input a file extension without the dot: (ex: cpp): ";
my $input = <>;
chomp($input);

open INPUT, "< gitChanges.txt" or die "Can't open input file: $!";
open OUTPUT, "> gitSubmit.txt" or die "Can't open output file: $!";

my $count = 0;
my $found = 0;
my $match = 0;

# reads in all lines of file one at a time
while (my $line = <INPUT>) {
	chomp $line;
	# find the line where git status was called
	if ($found == 0)
	{
		$match = ($line =~ /git status/);
		$found = 1;
	}
	# once we have found the line where status was called, copy all of the .cpp and .h file names
	else
	{
		if (($line =~ /\b[\w\/]*\.$input$/) == 1)
		{
			print "Match found: <$&>\n";
			$count++;
			print OUTPUT "git add $&; ";
		}
	}

	# once we find the git status line we can start checking for the file endings we want
	if ($match == 1)
	{
		$found = 1;
	}
	# a new file will be created and all output will be placed into the new file
	# with the same name as the original with the word edit in front
}

print "\nFound a total of $count files to submit.";
print "\nJust another Perl hacker...\n";

close INPUT;
close OUTPUT;
