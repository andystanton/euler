public class Imperative {
    private static final int MAX = 4000000;

    public static void main(String[] args) {
        int first = 1, second = 2, total = second, next;
        while(second < MAX) {
            next = first + second;
            first = second;
            second = next;
            if (next % 2 == 0) {
                total += next;
            }
        }
        System.out.println(total);
    }
}
