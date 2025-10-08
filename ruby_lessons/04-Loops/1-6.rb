print "Insert text: "
text = gets.chomp

print "Howmany times the text will be printed? "
count = gets.chomp.to_i

count.times do
    puts text
end