require "sqlite3"
db = SQLite3::Database.new "residents.db"

# Questions

# Tell with relations exist between the tables.
# For each table, explain which columns should be primary keys.
# For each table, explain which columns should be foreign keys.
# Please point out the weaknesses of this design. How would you do it better?

# Answer
# Let me explain the last tasks at first, there was a repeatable values on the database and thats not really good to see
# The people and home relation it should be many to many since many people can have many house, as we seen people and home doesn't have pivot table
# It makes the table doesn't looks clean and quite hard to manage.

# Back to question 1, 2, and 3, i'll add more table that contains home_id and people_id because many to many relationship require pivot table to do it
# And i edit on the pet table for the people_name column, i change that to people_id incase there's some condition of similiar people names
# Instead i'm using people_name, i'm using people_id for better data management and to prevent similiar name problem
# And also, i'm removing the owner_name column in homes table because its already declared in owner_home table
# Lets explain the relations! this is the sql of alter tables i did to improve the database:

# *DATABASE REFERENCE IN TASK 1-1*

# DROP & RECREATE tables because i can't use full feature of ALTER TABLE on sqlite3 :)
db.execute "DROP TABLE IF EXISTS pets;"
db.execute "DROP TABLE IF EXISTS homes;"
db.execute "DROP TABLE IF EXISTS people;"

# Make people table
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS people(
      id INTEGER PRIMARY KEY,
      name VARCHAR(50),
      sex VARCHAR(6),
      age TINYINT
  );
SQL

# Make home table
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS homes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      area VARCHAR(100),
      value INT
  );
SQL

# Nxt step, we need to make pivot table for home and people and add foreign key
db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS people_homes(
        id INTEGER PRIMARY KEY,
        people_id INT NOT NULL,
        home_id INT NOT NULL,
        FOREIGN KEY (people_id) REFERENCES people(id) ON DELETE CASCADE,
        FOREIGN KEY (home_id) REFERENCES homes(id) ON DELETE CASCADE
    );
SQL

# Make pets table with relation to people table
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS pets (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(50),
      type VARCHAR(50),
      owner_id INT NOT NULL,
      FOREIGN KEY (owner_id) REFERENCES people(id) ON DELETE CASCADE
  );
SQL

# So, the primary keys of each table is the ID of the table itself, like people table have people_id, homes table have home_id, etc
# And for the foreign key, there's 3 foreign keys, people_id, home_id, and owner_id in pets table, references in the SQL.

# The result looks like the image i've been designed in Improved_DB.png, located in this folder
puts "DB optimalized"


# Insert data to people table
# Asked AI to help me fill the data :)
db.execute <<-SQL
  INSERT INTO people (name, sex, age) VALUES
  ('Alice', 'Female', 25),
  ('Bob', 'Male', 28),
  ('Charlie', 'Male', 35),
  ('Diana', 'Female', 22);
SQL

# Insert data to homes table
db.execute <<-SQL
  INSERT INTO homes (area, value) VALUES
  ('Sunset Street', 250000000),
  ('Palm Residence', 375000000),
  ('Maple Avenue', 190000000),
  ('Country', 100000000);
SQL

# Insert data to pivot table (people_homes)
db.execute <<-SQL
  INSERT INTO people_homes (people_id, home_id) VALUES
  (1, 1), -- Alice owns Sunset Street
  (2, 1), -- Bob also lives in Sunset Street
  (2, 2), -- Bob also has Palm Residence
  (3, 3), -- Charlie owns Maple Avenue
  (4, 4); -- Diana lives in Country
SQL

# Insert data to tabel pets
db.execute <<-SQL
  INSERT INTO pets (name, type, owner_id) VALUES
  ('Milo', 'Cat', 1),
  ('Buddy', 'Dog', 2),
  ('Coco', 'Parrot', 3),
  ('Luna', 'Cat', 4),
  ('Rocky', 'Dog', 4);
SQL

puts "New data inserted successfully!"