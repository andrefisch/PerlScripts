use strict;
use warnings;
use File::Copy;

print "Renaming all files in current directory:\n";

my ($ext) = shift;
print "$ext\n";

# names of files to work with
my ($oldNames) = shift;
my ($newNames) = shift;

# arrays containing names of files from imports
my @old;
my @new;

open OLD, $oldNames or die "Can't open input file $!";
open NEW, $newNames or die "Can't open input file $!";

# take information from text files and put them into arrays
while (my $line = <OLD>)
{
    chomp $line;
    push (@old, $line);
}
while (my $line = <NEW>)
{
    chomp $line;

    push (@new, "$line\.$ext");
}

#print @old;
#print @new;

# rename the files
for(my $i = 0; $i < @old; $i++)
{
    print "Renaming <$old[$i]> to <$new[$i]>\n";
    rename ($old[$i], $new[$i]) or die(qq{Failed to move <$old[$i]> -> <$new[$i]>});
}

print "Just another perl hacker...\n";
