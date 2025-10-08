print "Insert a number, and i will guess the number: "
num = gets.chomp

low = 1
high = 100
attempts = 0

while true 
    guess = rand(1..100)
    attempts += 1

    puts "It is #{guess}, right?"
    print "Insert an answer, [A] if the number is right, [B] if the number is too big, [C] if the number is too small"
    answ = gets.chomp.downcase.to_s

    case answ
    when "a"
        puts "Yeah im smart enough, i've guessed your number with #{attempts} attempts!"
        exit
    when "b"
        high = guess - 1
    when "c"
        low = guess + 1
    else
        puts "Please use A, B, or C to answer."
    end
end