puts "Please give me 3 numbers:"
num1 = gets.chomp
num2 = gets.chomp
num3 = gets.chomp

# im using array and sort it
arr = [num1, num2, num3]
sort = arr.sort

# calling the first and the last array so i gst the biggest and smallest number easily
puts "#{sort[2]} is the biggest number."
puts "#{sort[0]} is the smallest number."