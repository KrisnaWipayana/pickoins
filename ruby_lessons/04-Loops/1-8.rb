print "Insert a number to check if it's prime or not: "
num = gets.chomp.to_i

def prime?(num)
  if num <= 1
    puts "#{num} is not a prime number"
    return
  end

  prime = true
  for i in 2...num
    if num % i == 0
      prime = false
      break
    end
  end

  if prime
    puts "#{num} is a prime number"
  else
    puts "#{num} is not a prime number"
  end
end

prime?(num)