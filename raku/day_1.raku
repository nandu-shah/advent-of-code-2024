my $fh = open('day_1-input');
my (@list1, @list2);
for $fh.lines -> $line {
    my ($i1, $i2) = $line.split(/\s+/);
    push(@list1, $i1.Int);
    push(@list2, $i2.Int);
}

@list1 .= sort;
@list2 .= sort;

say [+] (@list1 Z @list2).map({ abs(.[0] - .[1]) });

my $set = set @list1;
my $bag = bag @list2;
my $in = $set & $bag;

#say [+] $set.keys.map({ $_ * $bag{$_} });

say [+] $set.keys >>*>> $bag{@($set.keys)};
