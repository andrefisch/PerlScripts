sub chemistry
{
	$_ = join '', @_;
    s/(\w+\(\d+\))(\w+\(\d+\))(\w+\(\d+\))(\w+\(\d+\))/$3$2$1$4/;
    s/\((\d+)\).*\((\d+)\).*\((\d+)\).*\((\d+)\)/$1 / gcd($1, $2)$3$4/e;
    $_
}

print chemistry("Ba(1)Cl(2)", "H(2)SO4(1)");
print "\n";

sub gcd
{
    ($x, $y) = @_;
    ($x, $y) = ($y, $x % $y) while ($y != 0) 
}
