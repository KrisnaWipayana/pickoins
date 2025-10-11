require "sqlite3"
db = SQLite3::Database.new "residents.db"

db.execute <<-SQL
    INSERT INTO solution VALUES (67318, 'Jeremy Bowers');
SQL

puts "The murderer gets caught and get into the jail."