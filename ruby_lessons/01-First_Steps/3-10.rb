puts "Please give me 3 numbers:"

num1 = gets.chomp.to_i
num2 = gets.chomp.to_i
num3 = gets.chomp.to_i

res1 = (num1 + num2) % num3
res2 = ((num1 % num3) + (num2 % num3)) % num3
res3 = (num1 * num2) % num3
res4 = ((num1 % num3) * (num2 % num3)) % num3

puts "Result 1 is #{res1}"
puts "Result 2 is #{res2}"
puts "Result 3 is #{res3}"
puts "Result 4 is #{res4}"