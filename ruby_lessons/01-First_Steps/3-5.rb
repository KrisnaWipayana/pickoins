puts "Please give me 2 numbers:"

num1 = gets.chomp.to_i

num2 = gets.chomp.to_i

sum = num1 + num2
dif = num1 - num2
mul = num1 * num2
div = num1 / num2
rem = num1 % num2

puts "The sum result is #{sum}"
puts "The difference result is #{dif}"
puts "The multiplication result is #{mul}"
puts "The division result is #{div}"
puts "The reminder result is #{rem}"