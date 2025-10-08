students = [
    {
        name: "Lisa Takashi",
        birthday: "2002-03-04",
        japanese: 30,
        science: 60,
        pe: 95
    },
    {
        name: "Shirou Komura",
        birthday: "2001-09-23",
        japanese: 80,
        science: 20,
        pe: 25
    },
    {
        name: "Ichiro Takashi",
        birthday: "2002-05-29",
        japanese: 30,
        science: 85,
        pe: 45
    }
]

students.each do |s|
    puts "#{s[:name]} (birthday: #{s[:birthday]})"
    puts "Japanese: #{s[:japanese]}"
    puts "Science: #{s[:science]}"
    puts "PE: #{s[:pe]}"
    puts ""
end