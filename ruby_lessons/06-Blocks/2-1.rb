def repeat_whatever(n)
  n.times do
    yield if block_given?
  end
end

repeat_whatever(3) { puts "Wow!" }