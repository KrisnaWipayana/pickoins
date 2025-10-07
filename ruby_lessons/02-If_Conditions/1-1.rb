print "Please input your height (cm): "
height = gets.chomp.to_i

# normal if else, putting all the conditions
if height >= 200
    puts "Wow, you are big!"
elsif height <= 130
    puts "Wow, you are small!"
else
    puts "Normal height~"
end