print "Link destination: "
link = gets.chomp

print "Link text: "
text = gets.chomp

def simple_link_to(link, text)
    # puts "<a href= '#{link}'>#{text}</a>" #to test if the return is right, im using puts to see the output
    return "<a href= '#{link}'>#{text}</a>"
end

simple_link_to(link,text)