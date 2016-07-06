package Heap;

# my $heap = Heap->new;
# mark n
sub new 
{
    my $class = shift;
    my $self = 
    { 
        aref => [ "" ],
        next => 1,
        @_
    };
    bless $self, $class;
}

# heap->add(value_to_add)
# add puts the value in the next available array spot then increments the next variable
# mark a
sub add 
{
    my ($self, $value) = @_;
    my $i = $self->{next};
    $self->{aref}[$i] = $value;
    while ($i > 1) 
    {
        my $parent = POSIX::floor($i/2);
        last if $self->compare($i, $parent) <= 0;
        $self->swap($i, $parent);
        $i = $parent;
    }
    $self->{next}++;
}

# heap->compare(index_one, index_two)
# compares index_one with index_two
# mark c
sub compare 
{
    my ($self, $i, $j) = @_;
    my $x = $self->{aref}[$i];
    my $y = $self->{aref}[$j];
    if (!defined $x) 
    {
        if (!defined $y) 
        {
            return 0;
        } 
        else 
        {
            return -1;
        }
    }
    if (!defined $y) { return 1 }
    return $x <=> $y;
}

# heap->(index_one, index_two)
# swaps the items at the two indices
# mark s
sub swap 
{
    my ($self, $i, $j) = @_;
    my $aref = $self->{aref};
    ($aref->[$i], $aref->[$j]) = ($aref->[$j], $aref->[$i]);
}

# heap->remove
# returns first element of the heap
# mark r
sub remove 
{
    my $self = shift;
    my $aref = $self->{aref};
    my $result = $aref->[1];
    $aref->[1] = pop @$aref;
    $self->{next}--;
    $self->reheapify(1); # reheapify (great word) the tree
    return $result
}

# heap->reheapify
# reheapify (great word) the heap
sub reheapify 
{
    my ($self, $i) = @_;
    my $left = 2 * $i;
    my $right = 2 * $i + 1;
    my $winleft = $self->compare($i, $left) >= 0;
    my $winright = $self->compare($i, $right) >= 0;
    return if $winleft and $winright;
    if ($self->compare ($left, $right) > 0) 
    {
        $self->swap($i, $left);
        $self->reheapify($left);
    } 
    else 
    {
        $self->swap($i, $right);
        $self->reheapify($right);
    }
}

# heap->print
# prints the heap
# mark p
sub print 
{
    my $self = shift;
    my $next = $self->{next};
    my $aref = $self->{aref};
    print "array => @$aref\n";
    print "next => $next\n";
}

################
# TESTING AREA #
################
# mark z
my $heap = Heap->new;
for (my $i=0; $i<10; $i++) 
{
    $heap->add (rand 100);
}

$heap->print;


