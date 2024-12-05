my $fh = open('day_2-input');
my @lines;
for $fh.lines -> $line {
     push(@lines, [$line.split(' ')]);
 }


sub is_safe(@l) {
    my @diffs = @l.rotor(2 => -1).map({ .[1] - .[0] });
    return @diffs.map(*.abs).min >= 1
        && @diffs.map(*.abs).max <= 3
        && (@diffs.all() > 0 || @diffs.all() < 0);
}

sub drop1(@l) {
    (0 .. @l.end).map(-> $i { @l[0 ..^$i, $i+1 .. *].flat });
}

sub relaxed_is_safe(@l) {
    return is_safe(@l) || drop1(@l).grep(&is_safe);

}

say @lines.grep(&is_safe).elems;
say @lines.grep(&relaxed_is_safe).elems;
