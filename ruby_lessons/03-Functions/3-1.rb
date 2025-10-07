print "Insert first text: "
default = gets.chomp

print "Insert second text: "
named = gets.chomp

def make_polite(default, named)
    default = default.delete("。")
    
    if named == ""
        return "#{default}です"
    else
        return "#{default}#{named}"
    end
end

result = make_polite(default, named)
puts result