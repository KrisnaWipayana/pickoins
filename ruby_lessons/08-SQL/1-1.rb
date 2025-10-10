#i'll explaining the installation of sqlite3
#i'm using sqlite3 for this practice as the instruction requirements, the sqlite3 is required to do this practice
require "sqlite3"

#next, i'm making the database with "residents.db" for the name
db = SQLite3::Database.new "residents.db"

#sql command starts here, creating 3 tables with required columns on the instruction

#the usage of data type for the columns
#VARCHAR for text, we can limit the value (digits) of string by adding value in the type data
#INTEGER for numbers, usualy used for big numbers
#PRIMARY KEY for the key of the columns, we can use the primary key as main identity of the table

db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS people(
        id INTEGER PRIMARY KEY,
        name VARCHAR(50),
        sex VARCHAR(6),
        age TINYINT
    );
SQL

db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(50),
        type VARCHAR(50),
        owner_name VARCHAR(50)
    );
SQL

db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS homes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        owner_name VARCHAR(50),
        area VARCHAR(100),
        value INT
    );
SQL

puts "DB Created"