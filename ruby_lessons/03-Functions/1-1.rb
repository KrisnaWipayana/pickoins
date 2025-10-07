print "Name 1: "
name1 = gets.chomp

print "Name 2: "
name2 = gets.chomp

def greet_both(name1, name2)
    puts "Hello #{name1}, Hello #{name2}"
end

greet_both(name1, name2)