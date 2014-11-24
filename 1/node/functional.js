function range(max) {
    return Array.apply(null, Array(max)).map(function (_, i) {return i;});
}

var result = range(1000).reduce(function(previousValue, currentValue) {
    return previousValue + (currentValue % 3 == 0 || currentValue % 5 == 0 ? currentValue : 0);
});

console.log(result)
