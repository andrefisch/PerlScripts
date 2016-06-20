##############
# HOW TO USE #
##############

# This program takes one regex as a paramater then searches the dictionary
# file for any words that match that regex and prints them.
# Useful for cheating at crossword puzzles!
# NOTE: try putting the string inside double quotes if there is an error

sub crossword 
{
    my $pattern = shift;
    open FILE, "/usr/share/dict/words";
    while (my $line = <FILE>) 
    {
        print $line if ($line =~ m/$pattern/);
    }
}

print crossword(@ARGV);
