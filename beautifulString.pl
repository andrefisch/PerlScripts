use warnings;

sub quick 
{
    @a = join '', pop
    1 while s/(.)\1/$1/;
    $_
}

my $answer = quick($ARGV[0]);
print "$answer\n";
