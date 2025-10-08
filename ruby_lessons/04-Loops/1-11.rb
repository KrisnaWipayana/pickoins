print "Insert first number: "
a = gets.chomp.to_i

print "Insert second number: "
b = gets.chomp.to_i

digit1 = b % 10           
digit2 = (b / 10) % 10    
digit3 = b / 100      

line1 = a * digit1
line2 = a * digit2
line3 = a * digit3
total = a * b

puts line1
puts line2
puts line3
puts "Total: #{total}"