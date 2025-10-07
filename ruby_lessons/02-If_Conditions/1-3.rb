print "How old are you? "

age = gets.chomp.to_i

# im using true when the conditions is true, example (if the age < 3 then puts the message)
case true
when age < 3
    puts "You must be a baby."
when age < 20
    puts "You must be a child."
when age < 70
    puts "You must be an adult."
when age >= 70
    puts "You must be senior citizen"
end