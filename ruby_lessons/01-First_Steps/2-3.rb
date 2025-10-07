print "What is your name? "
name = gets.chomp


puts "Hello #{name}!"
animal = rand(1..2).to_i

if animal == 1
    puts "Here's a picture of a cat for you!"
    puts "\\    /\\"
    puts " )  ( ')"
    puts "(  /  )"
    puts " \\(__)|"
else
    puts "Here's a picture of a dog for you!"
    puts "|\\_/|"
    puts "|q p|   /}"
    puts "( 0 )\"\"\"\\"
    puts "|\"\^\"\'    |"
    puts "||_/=\\\\__|"
end