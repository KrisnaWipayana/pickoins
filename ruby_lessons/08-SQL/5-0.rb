# Here's all the SQL logs to show all the tables

sum@sum-HP-Laptop-14-em0xxx:~/Projects/ruby_lessons/08-SQL$ sqlite3
SQLite version 3.45.1 2024-01-30 16:01:20
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open police-database.db
sqlite> .tables
city_event_checkin    get_fit_now_check_in  interview           
crime_scene_report    get_fit_now_member    person              
drivers_license       income                solution 