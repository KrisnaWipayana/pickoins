print "Insert first number: "
num1 = gets.chomp.to_i

print "Insert second number: "
num2 = gets.chomp.to_i

if num1 > num2 # small validation to checj if num1 is smaller than num2
  temp = num1
  num1 = num2
  num2 = temp
end

sum = 0

for i in num1..num2
  print i
  sum = sum + i
  if i < num2
    print " + "
  end
end

puts
puts "The total is: #{sum}"
