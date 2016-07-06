package Person;
my $person = 
{ 
    name => "Allen B. Downey",
    webpage => "allendowney.com" 
};

bless $person, "Person";

sub new 
{
    my $class = shift;
    my $self = { @_ };
    bless $self, $class;
}

sub name 
{
    my $self = shift;
    if (@_) { $self->{name} = shift };
    return $self->{name};
}

sub webpage
{
    my $self = shift;
    if (@_) { $self->{webpage} = shift };
    return $self->{webpage};
}

sub print 
{
    my $self = shift;
    while ((my $key, my $value) = each %$self) 
    {
        print "$key => $value\n";
    }
}

# Both of the following lines do the same thing
name $person, "Nella B. Yenwod";
$person->name("Nella B. Yenwod");

# How to "construct" an object
my $new_person = Person->new(name => "Allen B. Downey");

$new_person->print;
