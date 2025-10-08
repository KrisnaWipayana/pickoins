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

def best_at(subject, students)
    best_std = students.max_by { |s| s[subject] }
    best_std[:name]
end

puts "The best student are: #{best_at(:japanese, students)}"