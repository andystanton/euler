import std.stdio;
import std.range;
import std.algorithm;

void main()
{
    writeln(sum(filter!(i => i % 3 == 0 || i % 5 == 0)(iota(1, 1000))));
}
