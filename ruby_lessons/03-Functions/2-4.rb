print "Link destination: "
dest = gets.chomp.to_s

print "Link name: "
name = gets.chomp.to_s.upcase

def important_link_to(dest, name)
    # puts "<a href = '#{dest}'>#{name}!!!</a>" #test
    return "<a href = '#{dest}'>#{name}!!!</a>"
end

important_link_to(dest, name)