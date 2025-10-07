print "Last name: "
lsname = gets.chomp

print "First name: "
fsname = gets.chomp

print "Age: "
age = gets.chomp.to_i

def print_adult_pass(lsname, fsname, age)

    if age < 20
        puts "******* Adult Pass (invalid) *********"
        puts "* Last Name:  #{lsname}"
        puts "* First Name:  #{fsname}"
        puts "is NOT an adult."
        puts "****************************"
    else
        puts "******* Adult Pass *********"
        puts "* Last Name:  #{lsname}"
        puts "* First Name:  #{fsname}"
        puts "is an adult."
        puts "****************************"
    end
end

print_adult_pass(lsname, fsname, age)