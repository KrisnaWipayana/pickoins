require "sqlite3"
db = SQLite3::Database.new "residents.db"
db.results_as_hash = true

result = db.execute <<-SQL
    SELECT pets.name AS "dog name"
    FROM pets
    JOIN people ON people.id = pets.owner_id
    JOIN people_homes ON people_homes.people_id = people.id
    JOIN homes ON homes.id = people_homes.home_id
    WHERE pets.type = 'dog' AND homes.area = 'Country'
    ORDER BY pets.name ASC;
SQL

puts "dog name"
puts "--------"
result.each do |res|
  puts res["dog name"]
end

# Once again, the data has been changed, but the flow of queries is still the same