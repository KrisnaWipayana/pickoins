require "sqlite3"
db = SQLite3::Database.new "residents.db"
db.results_as_hash = true # i've been searching how to print the result, so i used this method to print

# Small changes right here, since i changed the database sctructure, i'm calling people names in people table, not in pets table
# And 
result = db.execute <<-SQL
    SELECT DISTINCT people.name
    -- Deleting duplicate datas in people table, name column
    FROM people
    -- From pets people
    WHERE people.id NOT IN (
        -- Select all data where the owner doesn't have...
        SELECT DISTINCT  owner_id
        -- Deleting duplicate datas in owner_id column...
        FROM pets
        -- From pets table
        WHERE type = 'cat'
        -- Showing data to only cat type
        )
    ORDER BY people.id;
    -- Sorting the result by people id in people table (the default is ascending)
SQL

# Print the result
result.each do |res|
  puts "Owner name: #{res['name']}"
end