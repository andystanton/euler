using System;
using System.Linq;
using System.Collections.Generic;

public class One
{
    static public void Main ()
    {
        Console.WriteLine(Enumerable.Range(1, 999).Where(x => x % 3 == 0 || x % 5 == 0).Sum());
    }
}
