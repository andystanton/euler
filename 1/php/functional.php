<?php
    $result = array_sum(
        array_filter(range(1, 999), function ($item) {
            return $item % 3 == 0 || $item % 5 == 0;
        })
    );
    print($result)
?>
