sub rand_elt { $_[rand @_] }

sub triple_line {
    my @list = split " ", shift;
    foreach my $word (@list) {
        triple_word $word;
    }
}

sub triple_word {
    our (@prefix, %hash);
    my $word = shift;

    if (@prefix == 2) {
        my $key = join " ", @prefix;

        my $aref = $hash{$key};
        push @$aref, $word;
        $hash{$key} = $aref;

        shift @prefix;
    }
    push @prefix, $word;
}

read_file $file, \&triple_line;
