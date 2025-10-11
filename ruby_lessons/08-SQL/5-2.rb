require "sqlite3"
db = SQLite3::Database.new "residents.db"

db.execute <<-SQL
    INSERT INTO solution VALUES (99716, 'Miranda Priestly');
SQL

puts "The real villain was caught and get into the jail"