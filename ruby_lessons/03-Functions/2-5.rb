print "Insert text: "
text = gets.chomp

print "Insert Color Code: "
code = gets.chomp.to_i

def colorize(text, code)
    puts "\e[#{code}mThis is important\e[0m"
end

colorize(text, code)


print "Insert text: "
text = gets.chomp

def colorize_red(text, code)
    return colorize(text, 31)
end

colorize_red(text, code)


print "Insert text: "
text = gets.chomp

def colorize_yellow(text, code)
    return colorize(text, 33)
end

colorize_yellow(text, code)