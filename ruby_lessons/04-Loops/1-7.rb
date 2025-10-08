field = 1
grains = 2

for f in 1..64
    puts "Field #{field}: #{grains}"
    field += 1
    grains *= 2
end

puts "SUM of all grains on the chessboard is #{grains} grains"

# asked AI to get some information
# average one grain mass is 0.029 grams

mass = grains * 0.029
puts "Total mass of grains: #{mass} grams"

# asked ai how to format the number of grams :)
tons = mass / 1000000
format_tons = tons.to_i.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
puts "We get around #{format_tons} tons for sure :)"

# lets assume 1 sack of grains is 50kg
sack = mass / 50000 #50.000 grams is 50kg
puts "Total sack of grains: #{sack.to_i}"

# i dont really know about Japan production amout for sack of grains, so i assume 10.363.900/year (from AI)
# so lets count using my ASSUMED numbers by AI
prod = tons / 10363900
puts "It takes #{prod.to_i} years for japan to produce it"