sub LastTwo {
    ($n, $k) = @_;
    A(A($n) ** A($k))
}

sub A{
    substr pop, -2
}

print A($ARGV[0]);
print "\n";
print A($ARGV[1]);
print "\n";
print eval 55**13;
print "\n";
print LastTwo (@ARGV);
print "\n";
