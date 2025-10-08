num = rand(1..100).to_i

for i in 1..100
    print "Guess a number from 1 to 100: "
    guess = gets.chomp.to_i

    if guess < num
        puts "#{guess} is too small"
    elsif guess > num
        puts "#{guess} is too big"
    else
        puts "Congratulations, you guessed the number!"
        puts "You managed in #{i} entries"
        exit
    end
end