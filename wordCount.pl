use strict;
use warnings;

our %hash;

sub read_file 
{
    my $file = shift;
    open (FILE, $file) || die "Couldn’t open $file";
    while (my $line = <FILE>) 
    {
        # Replace all dashes with spaces
        $line =~ tr/———'’/ /d;
        # Then remove all other punctuation
        $line =~ s/[^ \w\n]//g;
        read_line($line);
    }
    print_hash();
}

sub read_line 
{
    my @list = split " ", shift;
    foreach my $word (@list) 
    {
        $hash{lc $word}++;
    }
}

sub print_hash
{
    foreach my $count (sort { $hash{$a} <=> $hash{$b} } keys %hash)
    {
        printf "%-16s %s\n", $count, $hash{$count};
    }
}

read_file(@ARGV);
