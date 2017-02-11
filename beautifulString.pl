use warnings;

sub quick 
{
    $_ = pop;
    1 while s/(.)\1//;
    !$_
}


my $answer = quick($ARGV[0]);
print "$answer\n";
