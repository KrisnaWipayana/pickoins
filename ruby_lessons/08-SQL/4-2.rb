require 'sqlite3'
db = SQLite3::Database.new "residents.db"

rows = db.execute <<-SQL
  SELECT p.name,
         MAX(h.value) AS "house value"
  FROM people p
  JOIN people_homes ph ON p.id = ph.people_id
  JOIN homes h ON ph.home_id = h.id
  WHERE h.value > 200000
  GROUP BY p.name
  ORDER BY "house value" DESC;
SQL

puts "name\t\thouse value"
puts "----------------------"
rows.each do |name, value|
  puts "#{name}\t\t#{value}"
end

# Once again, the data has been changed, but the flow of queries is still the same