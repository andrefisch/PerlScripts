use warnings;

sub quick 
{
    $_ = join ' ', @{$_[0]};
    s/(.+)/ $1 /;
    print "$_\n";
    # check to make sure no word is contained in another
    # THESE LINES WORKS PERFECTLY
    1 while s/\b([^ ]+)\b(.*)\1/$2$1/; 
    1 while s/([^ ]+)(.*)\b\1\b/$1$2/;
    print "after removing words contained by other words: $_\n";
    # check for connections at word boundaries
    $_ = reverse;
    1 while s/ ([^ ]+)(.*) ([^ ]+\1) / $3$2 /;
    print "after removing $_\n";
    # $_ = reverse;
    print "after reversing $_\n";
    1 while s/([^ ]+)\b(.*) (\1[^ ]+)/$3$2/;
    s/ //g;
    $_ = reverse;
    print "$_\n";
    length
}

#{{{
=cut
my $answer = quick(["jumpy", "python", "oneiric"]);
print "$answer : 14\n\n";
$answer = quick(["foo", "bar"]); 
print "$answer : 6\n\n";
$answer = quick(["7", "71", "281", "4523", "74713"]); 
print "$answer : 12\n\n";
$answer = quick(["abcd", "cdef", "bcdef"]); 
print "$answer : 6\n\n";
$answer = quick(["califrag", "fragilistic", "supercalifragilisticexpialidocious", "expialidocious"]); 
print "$answer : 34\n\n";
$answer = quick(["abc", "bcad", "def", "bcd"]); 
print "$answer : 10\n\n";
$answer = quick(["test"]); 
print "$answer : 4\n\n";
$answer = quick(["stop", "", "topper", "stop", "", "past"]); 
print "$answer : 9\n\n";
$answer = quick([""]); 
print "$answer : 0\n\n";
$answer = quick(["printy", "printly"]);
print "$answer : 13\n\n";
$answer = quick(["snapple", "mapple"]);
print "$answer : 13\n\n";
$answer = quick(["cde", "ab", "bcd", "a", "bcde", "bc"]);
print "$answer : 5\n\n";
$answer = quick(["random", "moat", "dome"]);
print "$answer : 11\n\n";
$answer = quick(["aaabbb", "bbbaaa", "bbbccc"]);
print "$answer : 12\n\n";
$answer = quick(["apples", "oranges", "bananas", "asand"]);
print "$answer : 23\n\n";
=cut
#}}}

$answer = quick(["22345", "123456", "4567"]);
print "$answer : 12\n\n";
$answer = quick(["123456", "22345", "4567"]);
print "$answer : 12\n\n";
$answer = quick(["54322", "654321", "7654"]);
print "$answer : 12\n\n";
$answer = quick(["654321", "54322", "7654"]);
print "$answer : 12\n\n";
$answer = quick([]);
print "$answer : 0\n\n";
