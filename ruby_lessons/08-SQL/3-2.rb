require "sqlite3"
db = SQLite3::Database.new "residents.db"
db.results_as_hash = true # i've been searching how to print the result, so i used this method to print

# There was little changes at 
result = db.execute <<-SQL
    SELECT name, age, COUNT(name) AS count_homes
    -- Selecting name, ages, and count homes per person own
    FROM people, people_homes
    -- From table people and homes (Join)
    WHERE people.id = people_homes.people_id
    -- Filtering only those person name matches the home's owner
    GROUP BY name
    -- Groups all the same data by name (people.name)
    ORDER BY count_homes DESC, name;
    -- Showing all the home count descending, it means showing from people with more house first
    -- And by the name when counts equal
SQL

# Print the result
result.each do |res|
  puts "Name: #{res['name']}, Age: #{res['age']}, Home count: #{res['count_homes']}"
end