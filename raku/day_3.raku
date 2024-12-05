my regex DO { do\(\) };
my regex DON'T { don\'t\(\) }; # ' Escape to handle broken parsing
my regex NUM { \d+ }
my regex MUL { mul\(<NUM>\,<NUM>\) };

grammar Day3_pt1 {
    rule TOP { <mul>* }
    rule mul   { <MUL> }
}

class Actions_pt1 {
    has Int  $!sum     = 0;

    method mul($/) {
        $!sum += $<MUL><NUM>[0].Str.Int * $<MUL><NUM>[1].Str.Int;
    }

    method sum { $!sum }
}

grammar Day3_pt2 {
    rule TOP { <instruction>* }
    rule instruction {
        | <do>
        | <dont>
        | <mul>
    }
    rule do    { <DO> }
    rule dont  { <DON'T> }
    rule mul   { <MUL> }
}

class Actions_pt2 {
    has Bool $!enabled = True;
    has Int  $!sum     = 0;

    method do($/)    { $!enabled = True }
    method dont($/)  { $!enabled = False }
    method mul($/) {
        if $!enabled {
            $!sum += $<MUL><NUM>[0].Str.Int * $<MUL><NUM>[1].Str.Int;
        }
    }

    method sum { $!sum }
}

sub cleanse($s, $r) {
    my @clean = $s ~~ m:g/($r)/;
    @clean.map({ .join('') }).join('');
}

my $fh = open('day_3-input');
my $input = $fh.slurp;

my $clean_input = cleanse($input, /(<MUL>)/);
my $parsed = Day3_pt1.parse($clean_input, :actions(Actions_pt1.new));

say $parsed.actions.sum;


$clean_input = cleanse($input, /(<DO> || <DON'T> || <MUL>)/);
$parsed = Day3_pt2.parse($clean_input, :actions(Actions_pt2.new));

say $parsed.actions.sum;
