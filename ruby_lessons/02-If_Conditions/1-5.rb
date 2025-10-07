print "Give time unit (days/hours/second): "
unit = gets.chomp.downcase

print "How many #{unit}? "
value = gets.chomp.to_i

print "To which time units do u want to convert? "
conv = gets.chomp.downcase

# using nested case to get the time units and convert units, i need to know the time unit and the value first
# then i can ask user for the convert units
# users cant ask for same time unit convertion, im not adding the same time unit in the cases
case unit
when "days"
    case conv
    when "hours"
        result = value * 24
    when "second"
        result = value * 86400
    end

when "hours"
    case conv
    when "days"
        result = value / 24
    when "second"
        result = value * 3600
    end

when "second"
    case conv
    when "days"
        result = value / 86400
    when "hours"
        result = value / 3600
    end
end

puts "#{value} #{unit} are #{result} #{conv}"