import java.util.stream.*;

public class RangeStream {
    public static void main(String[] args) {
        int result = IntStream.range(1, 1000).filter(i -> {
            return i % 3 == 0 || i % 5 == 0;
        }).sum();
        System.out.println(result);
    }
}
