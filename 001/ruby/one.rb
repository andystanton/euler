puts (1..999).to_a.keep_if{|i| i % 3 == 0 || i % 5 == 0}.inject{|sum,x| sum + x }
