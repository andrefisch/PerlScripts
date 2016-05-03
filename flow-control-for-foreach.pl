use strict;
use warnings;

# FOR LOOP SAME AS IN C OR JAVA
for (my $i = 10; $i >= 0; $i--) { # must have parentheses
    print "$i...\n";              # Body must be in braces 
}


# FOREACH ITERATES OVER A LIST OR ARRAY 
foreach my $i (reverse 0..10) {   # must have parentheses
    print "$i...\n";              # Same as above. Countdown
}                                 # range is inclusive [0..10]


# ANOTHER FOREACH EXMAPLE 
my $N = 9;
foreach (0..$N) {                 # must have parentheses
    print "$_... ";               # range .. must be increasing 
}


# THE THIRD FOREACH EXMAPLE
my %hash = (dog => "lazy", fox => "quick");
foreach my $key (keys %hash) {    # must have parentheses
    print "\nThe $key is $hash{$key}";  
} 

# SAME AS ABOVE, BUT USE A LIST VARIABLE 
my @list = keys %hash;
foreach my $key (@list) {         # must have parentheses
    print "\nThe $key is $hash{$key}.";  
}
      
print "\n";