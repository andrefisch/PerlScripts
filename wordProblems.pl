use strict;
use warnings;

my $string = '
J
u
l
i
a
 
p
l
a
y
e
d
 
t
a
g
 
w
i
t
h
 
1
2
 
k
i
d
s
 
o
n
 
M
o
n
d
a
y
.
 
S
h
e
 
p
l
a
y
e
d
 
t
a
g
 
w
i
t
h
 
7
 
k
i
d
s
 
o
n



T
u
e
s
d
a
y
.
 
H
o
w
 
m
a
n
y
 
k
i
d
s
 
d
i
d
 
s
h
e
 
p
l
a
y
 
w
i
t
h
 
a
l
t
o
g
e
t
h
e
r
?

';

$string =~ s/\n//g;

my $problem = "";

############
# ADDITION #
############

my $match = ($string =~ /in all|total|are there|how many|sum|how old|how much/i);

if ($match == 1)
{
	my @match = ($string =~ /\d+/g);
	for (my $i = 0; $i < scalar @match; $i++)
	{
		$problem .= "$match[$i]";
		if ($i != scalar @match - 1)
		{
			$problem .= " + ";
		}
	}
}
else
{
	print "No Match\n"
}

print "$problem\n";

reset;