def short_name(user)
    initial1 = user[:first_name][0].upcase
    initial2 = user[:last_name][0].upcase

    puts "#{initial1}. #{initial2}."
end

user = {first_name: "Krisna", last_name: "Wipayana"}

short_name(user)