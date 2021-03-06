(defun sum-list (list)
    (if list
        (+ (car list) (sum-list (cdr list)))
        0))

(defun rangeDivisibleBy3or5 (min max)
    (loop for n from min below max
        when (or (= (mod n 3) 0) (= (mod n 5) 0))
        collect n))

(format t "~S~%" (sum-list (rangeDivisibleBy3or5 1 1000)))
