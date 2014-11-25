public class ClassicRecursion {
    private static final int MAX = 4000000;

    private static int sumFib(int first, int second) {
        int next = first + second;
        int base;
        if (next < MAX) {
            base = sumFib(second, next);
        } else {
            base = (next % 2 == 0) ? next : 0;
        }
        return base + (second % 2 == 0 ? second : 0);
    }

    public static void main(String[] args) {
        System.out.println(sumFib(1, 2));
    }
}
