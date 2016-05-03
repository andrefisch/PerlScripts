=begin ghostcode

 input array
 create new array
 for each element in array
	search new array for element
	if not present add new element
 
 O(n^2)

 input array
 create new sort array
 create new output array
 for each element in array
 	search new sort array for element
	if not present add to correct spot in sort array so list is sorted and add to end of output array

 O(nlogn)

=cut

use strict;
use warnings;

my @fibfib = (1, 1, 2, 2, 3, 5, 8, 11, 12, 19, 19, 20, 49, 49, 49, 49, 50, 1, 49);
my @new;
my $flag = 0;
my $comparisons = 0;

# push @new, $fibfib[0];

# for each elenent in original array
for (my $i = 0; $i <= $#fibfib; $i++)
{
	$flag = 1;
	#we look through new array to see if there is a duplicate
	for (my $j = 0; $j <= $#new; $j++)
	{
		$comparisons++;
		#end if we find a duplicate and 
		if ($new[$j] == $fibfib[$i])
		{
			$flag = 0;
			last;
		}
	}
	push @new, $fibfib[$i] if ($flag == 1);
}

print "contents of new array:\n";
for (my $i = 0; $i <= $#new; $i++)
{
	print "$new[$i], ";
}
print "\n";
print "number of comparisons: $comparisons\n";
