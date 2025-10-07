print "Length: "
leng = gets.chomp.to_i

print "Height: "
heig = gets.chomp.to_i

print "Width: "
widt = gets.chomp.to_i

def surface_of_cuboid(leng, heig, widt)
    result = 2 * ((leng * widt) + (widt * heig) + (leng * heig))
    # puts result #test
    return result
end

surface_of_cuboid(leng, heig, widt)