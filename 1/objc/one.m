#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
    int sum = 0, i;
    for (i = 0; i < 1000; i++)
    {
        if (i % 3 == 0 || i % 5 == 0)
        {
            sum += i;
        }
    }
    printf ("%i\n", sum);
    return 0;
}
