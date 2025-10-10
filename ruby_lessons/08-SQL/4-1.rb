require 'sqlite3'
db = SQLite3::Database.new "residents.db"

result = db.execute <<-SQL
    SELECT type AS pet, COUNT(type) as count
    FROM pets
    GROUP BY type
    ORDER BY pet;
SQL

puts "Type\tCount"
puts "---------------"
result.each do |res|
  puts "#{res[0]}\t#{res[1]}"
end

# Since the data has been changed from 2-1, it returns different data but the return flow are following the instruction