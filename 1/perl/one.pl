use List::Util qw(reduce);
print reduce { $a + ($b % 3 == 0 || $b % 5 == 0 ? $b : 0) } 0, 1..999;
