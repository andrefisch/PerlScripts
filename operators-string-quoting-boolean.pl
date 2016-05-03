use strict;
use warnings;

########### string operators
print "########### string operators\n";
        my $bark = "Woof!";
        $bark .= ".. ";                 # Append a string 
        $bark x= 5;                     # Repeat 5 times
        print "The dog barked: $bark\n\n";
      

########### quoting operators
print "########### quoting operators\n";
        my $cat = "meow";
        my $sound = "$cat";             # $sound = "meow"
        my $variable = '$cat';          # $variable = "\$cat"
        print "$variable says $sound\n";

        $sound = qq{"meow"};            # If you want to quote quotes 
        $sound = qq("meow");            # Same
        print "$variable says $sound\n";

	my $sound2 = qq*bah*;		# own delimiters
	$sound2 = qq(bah);		# same
	print "sound is now $sound2\n";

        my $contents = `cat $sound $sound2`; # contents of files "meow" and "bah"
	print "$contents\n";


############ boolean operators
print "############ boolean operators\n";
        # RELATIONAL AND CONDITIONAL
	my ($x, $y) = (12, 100);
        my $smaller = $x < $y ? $x : $y;                # conditional ?:
        print "The smaller number is $smaller.\n";

        # EQUALITY
        my ($a, $b) = ("apple", "orange");
        print "1: apples are oranges\n" if ($a eq $b);  # Stringwise. False
        print "2: apples are oranges\n" if ($a == $b);  # Numerical. True!

        # RELATIONAL
        my ($x, $y) = (12, 100);
        print "3: $x is more than $y\n" if ($x gt $y);  # Stringwise. True!
        print "4: $x is more than $y\n" if ($x > $y);   # Numerical. False
      
        # LOGICAL
        print (1 and 1 or 0 and 0); print "\n";         # high-> low: not, and, or
        print (1 and 1 || 0 and 0); print "\n";         # symbolic has higher precedence 