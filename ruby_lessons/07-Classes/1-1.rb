class Pair

    def initialize(first, second)
        @first = first
        @second = second
    end

    def sum
        @first + @second
    end

    def swap!
        @first, @second = @second, @first
    end

    def inspect
        "A pair of #{@first} and #{@second}"
    end

    def self.default
        Pair.new(0, 0)
    end
end

pair = Pair.new(1, 3)

puts pair.inspect
puts "Total sum: #{pair.sum}"

pair.swap!
puts "And it swaps to #{pair.inspect}"

def_pair = Pair.default
puts "The default pair was: #{def_pair.inspect}"
