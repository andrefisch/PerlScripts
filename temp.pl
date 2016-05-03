use strict;
use warnings;

# DIE STATEMENT SYNTAX: a string + a modifier
sub fibonacci {
    my ($n) = @_;
    die "Number must be positive" if $n <= 0;
    return 1 if $n <= 2;
    return (fibonacci($n-1) + fibonacci($n-2));
}


# CALLING FIVE TIMES
foreach my $i (1..100) {
    #my $fib = fibonacci($i);
    my $fib = fibonacci $i;
    print "fibonacci($i) is $fib\n";
}
      

# CALLING WITH A NEGATIVE NUMBER. RAISE AN EXCEPTION 
print fibonacci(-2);