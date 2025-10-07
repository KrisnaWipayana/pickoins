puts "Please select a plan [A - D]"
puts "A) Super E"
puts "B) Easy Energy"
puts "C) Natural Energy"
puts "D) Premium Charging"

plan = gets.chomp.upcase

print "KwH: "
kwh = gets.chomp.to_i

if kwh >= 0 && kwh <= 1000 #based on the instructions, im using nested if and case in the 2th if to categorize the plan and count the monthly bills

    print "A: "
    a = gets.chomp.to_i

    if a == 5 || a == 10 || a == 20 || a == 30 || a == 40
        case plan
        when "A"
            if a == 5 || a == 10
                puts "5A and 10A can't be used in this plan"
                exit
            else
                bill = 30.4 * a + kwh * 84.23
            end

        when "B"
            bill = (10.4 * a + kwh * 44.2) + 1000

        when "C"
            bill_sum = 33.2 * a + kwh * 74.2
            bill_win = 33.2 * a + kwh * 90.25
            
            puts "This month's energy bill is: #{bill_sum} for summer, and #{bill_win} for winter"
            exit
        when "D"
            bill = 830 + kwh * 104.71
        end
    else
        puts "A only can be 5, 10, 20, 30, 40!"
        exit
    end
else
    puts "KwH must between 0-1000!"
    exit
end

if kwh == 0 #cut the bills by 50% if kwh is 0
    bill = bill * 0.5
    puts "This month's energy bill: ¥#{bill.round(2)}"
else
    puts "This month's energy bill: ¥#{bill.round(2)}"
end