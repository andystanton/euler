fn main() {
    let mut sum = 0;
    for i in range(1, 1000u).filter(|&i| i % 3 == 0 || i % 5 == 0) {
        sum += i;
    }
    println!("{}", sum);
}
