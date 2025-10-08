def binary_exponentiation
    number = 1
    while true
        yield number
        number *= 2
    end
end

def colorize_red(num)
  "\e[31m#{num}\e[0m"
end

limit = 2**40

binary_exponentiation do |number|
  break if number >= limit
  output = 
  case number
  when 1024, 1048576, 1073741824
    colorize_red(number.to_s)
  else
    number.to_s
  end
  puts output
end