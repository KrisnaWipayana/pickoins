require "sqlite3"
db = SQLite3::Database.new "residents.db"
db.results_as_hash = true # i've been searching how to print the result, so i used this method to print

result = db.execute <<-SQL
    SELECT *
    -- Selecting all data
    FROM people
    -- From people table
    WHERE age < 30
    --And it only pick data where age is less than 30
    ORDER BY age ASC;
    --Showing the data from the youngest to oldest age (ascending)
SQL

# Print the result
result.each do |res|
  puts "Name: #{res['name']}, Age: #{res['age']}"
end