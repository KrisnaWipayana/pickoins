require "sqlite3"
db = SQLite3::Database.new "residents.db"

people = [
  ['Austin', 'M', 33],
  ['Blair', 'M', 90],
  ['Carolina', 'F', 28],
  ['Dani', 'F', 28],
  ['Donald', 'M', 70],
  ['Eliza', 'F', 37],
  ['Farida', 'F', 23],
  ['Georgina', 'F', 19],
  ['Hillary', 'F', 68],
  ['Leland', 'M', 16],
  ['Liam', 'M', 22],
  ['Michael', 'M', 48],
  ['Phoebe', 'F', 52],
  ['Sherry', 'F', 39],
  ['Zed', 'M', 42]
]

people.each do |name, sex, age|
  db.execute("INSERT INTO people (name, sex, age) VALUES (?, ?, ?)", [name, sex, age])
end

puts "people data inserted successfully!"


pets = [
  ['Maru', 'cat', 'Austin'],
  ['Icey', 'dog', 'Blair'],
  ['Maxie', 'dog', 'Blair'],
  ['Rex', 'dog', 'Carolina'],
  ['Harambe', 'bird', 'Dani'],
  ['Syd', 'dog', 'Dani'],
  ['Artemis', 'cat', 'Dani'],
  ['Mr. Muggles', 'cat', 'Donald'],
  ['Meowser', 'cat', 'Donald'],
  ['Donald', 'cat', 'Donald'],
  ['Hodor', 'bird', 'Eliza'],
  ['Bumpkin', 'horse', 'Georgina'],
  ['Secretariat', 'horse', 'Hillary'],
  ['Socks', 'dog', 'Hillary'],
  ['Sir Barks-Alot', 'dog', 'Liam'],
  ['Harry Potter', 'horse', 'Leland'],
  ['Xerses', 'horse', 'Michael'],
  ['Zeus', 'cat', 'Michael'],
  ['Rocket', 'cat', 'Phoebe'],
  ['Kermit', 'dog', 'Sherry'],
  ['Hector', 'dog', 'Sherry'],
  ['Essy', 'dog', 'Sherry'],
  ['Samwise', 'dog', 'Sherry'],
  ['Jenkins', 'horse', 'Zed']
]

pets.each do |name, type, owner_name|
  db.execute("INSERT INTO pets (name, type, owner_name) VALUES (?, ?, ?)", [name, type, owner_name])
end

puts "pets inserted successfully!"


homes = [
  ['Austin', 'urban', 145000],
  ['Blair', 'suburbs', 95000],
  ['Carolina', 'suburbs', 220000],
  ['Carolina', 'urban', 190000],
  ['Dani', 'country', 67000],
  ['Donald', 'urban', 450000],
  ['Donald', 'urban', 260000],
  ['Donald', 'urban', 660000],
  ['Eliza', 'urban', 210000],
  ['Farida', 'suburbs', 180000],
  ['Georgina', 'country', 82000],
  ['Hillary', 'country', 380000],
  ['Hillary', 'urban', 400000],
  ['Leland', 'country', 42000],
  ['Liam', 'suburbs', 160000],
  ['Michael', 'suburbs', 160000],
  ['Michael', 'country', 82000],
  ['Phoebe', 'urban', 77000],
  ['Sherry', 'urban', 210000],
  ['Zed', 'country', 177000]
]

homes.each do |owner_name, area, value|
  db.execute("INSERT INTO homes (owner_name, area, value) VALUES (?, ?, ?)", [owner_name, area, value])
end

puts "homes inserted successfully!"