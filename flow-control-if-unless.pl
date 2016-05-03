use strict;
use warnings;

# NOTE:
# Both if and unless must have the entire predicate in parenthese

# SIMULTANEOUS ASSIGNMENT TO MULTIPLE VARIABLES
my ($a, $b) = (0, 0);

# ! takes precedence over &&
if (!$a && !$b)        {print "Neither\n";} # Conventional

# not takes precedence over and
if (not $a and not $b) {print "Neither\n";} # Same, but in English

# or has lower precedence, thus must be in parentheses
if (not ($a or $b))    {print "Neither\n";} # Same, but parentheses

# MUST BE IN PARENTHESES
unless ($a or $b)      {print "Neither\n";} # Same, but clearest



# REPEATING ABOVE, WITH A DIFFERENT SET OF a, b VALUES
($a, $b) = (0, 1); 
if (!$a && $b)         {print "False and true\n";} # Conventional
if (not $a and $b)     {print "False and true\n";} # Same, but in English
if (not ($a or !$b))   {print "False and true\n";} # Same, but parentheses
unless ($a || !$b)     {print "False and true\n";} # Same, used symbolic or 
