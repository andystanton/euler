import std.stdio;
void main()
{
    auto sum = 0;
    foreach (value; 0..1000) {
        if (value % 3 == 0 || value % 5 == 0) {
            sum += value ;
        }
    }
    writeln(sum);
}
