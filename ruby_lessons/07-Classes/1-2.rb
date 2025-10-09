class Color

    def initialize(red, green, blue, opacity = nil)
        @red = red
        @green = green
        @blue = blue
        @opacity = opacity
    end
    
    def to_css_func
        if @opacity == nil
            "rgb(#{@red}, #{@green}, #{@blue})"
        else
            "rgb(#{@red}, #{@green}, #{@blue}, #{@opacity})"
        end
    end
    
    #getting trouble when i print the return value without the parameters of .rjust
    #and AI suggest me to add some values (2, '0') to get the right return
    def to_hex
        r = @red.to_s(16).rjust(2, '0').upcase
        g = @green.to_s(16).rjust(2, '0').upcase
        b = @blue.to_s(16).rjust(2, '0').upcase

        "##{r}#{g}#{b}"
    end

    def add(other_color)
        
        #validates color value amd sent the ArgumentError if the color format is wrong
        unless other_color.is_a?(Color)
            raise ArgumentError, "Argument must be an instance of Color"
        end

        new_red   = [@red + other_color.red, 255].min
        new_green = [@green + other_color.green, 255].min
        new_blue  = [@blue + other_color.blue, 255].min

        Color.new(new_red, new_green, new_blue, @opacity)
    end

    #get stuck on error when im trying to access other_color.red, green and blue at the add function, so i ask AI to solve and i should
    #use attr_reader to access red, green, blue, opacity value
    attr_reader :red, :green, :blue, :opacity
end


white = Color.new(255, 255, 255)
green = Color.new(0,255,0)
transparent_blue = Color.new(0,0,255,0.7)
red = Color.new(255,0,0)
green = Color.new(0,255,0)
yellow = red.add(green)

puts white.to_hex
puts transparent_blue.to_css_func
puts yellow.to_hex