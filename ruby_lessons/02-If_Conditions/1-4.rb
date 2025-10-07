print "Insert your weight in kilogram "
weight = gets.chomp.to_f

print "Insert your height in centimeter "
height = gets.chomp.to_f

height = height / 100 #i need to convert the height to meters first, so the calculation can be true

bmi = weight / (height * height)

# using case to categorize the bmi index
case true
when bmi < 18.5
    category = "Underweight"
when bmi = 18.5..24.9
    category = "Healthy"
when bmi = 25.0..29.9
    category = "Overweight"
when bmi >= 30
    category = "Obesity"
end

puts "Your Body Mass Index is #{bmi}"
puts "This means you belong to category #{category}"