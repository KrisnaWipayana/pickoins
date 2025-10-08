print "First number: "
num1 = gets.chomp.to_i

print "Second number: "
num2 = gets.chomp.to_i

if num1 <= num2
    for i in num1..num2
        puts i
    end
else
    for i in num1.downto(num2)
        puts i
    end
end