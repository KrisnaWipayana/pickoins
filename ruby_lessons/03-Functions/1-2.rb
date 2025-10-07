print "Number 1: "
num1 = gets.chomp.to_i

print "Number 2: "
num2 = gets.chomp.to_i

def print_multiplication(num1, num2)

    result = num1 * num2
    puts "#{num1} times #{num2} is #{result}."
end

print_multiplication(num1, num2)