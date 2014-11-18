#(1..9).to_a.keep_if{|i| i % 3 == 0 || i % 5 == 0}.each{|i| puts i}
sum=0
(1..999).to_a.keep_if{|i| i % 3 == 0 || i % 5 == 0}.each{|i| sum += i}

puts sum
