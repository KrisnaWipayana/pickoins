# Here's the short process finding the data
sum@sum-HP-Laptop-14-em0xxx:~/Projects/ruby_lessons/08-SQL$ sqlite3
SQLite version 3.45.1 2024-01-30 16:01:20
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open police-database.db
sqlite> SELECT * FROM crime_scene_report
   ...> WHERE city = 'SQL City'
   ...> ;
20180215|murder|REDACTED REDACTED REDACTED|SQL City
20180215|murder|Someone killed the guard! He took an arrow to the knee!|SQL City
20170712|theft|A lone hunter stalks the night, firing arrows into the Darkness.
            There is no hiding, no escape. In the distance, the beast
            falters, tethered to the void. The killing blow comes without
            hesitation, without mercy.|SQL City
20170820|arson|Wield the Hammer of Sol with honor, Titan, it is a thing of
            legend, both past and future.|SQL City
20171110|robbery|The Gjallarhorn shoulder-mounted rocket system was forged from
            the armor of Guardians who fell at the Twilight Gap. Gifted
            to the survivors of that terrible battle, the Gjallarhorn
            is seen as a symbol of honor and survival.|SQL City
20180103|bribery|Apparently, Cayde thought it necessary to expose this extremely
            rare vegetable to a Hive summoning ritual.|SQL City
20180115|assault|Hamilton: Lee, do you yield? Burr: You shot him in the side! Yes he yields!|SQL City
20180115|assault|Report Not Found|SQL City
20180115|murder|Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".|SQL City



# Here's the result selecting crime_scene_repord based in SQL City
sqlite> .mode column
sqlite> .headers on
sqlite> SELECT * FROM crime_scene_report
   ...> WHERE city = 'SQL City';
date      type     description                                                   city    
--------  -------  ------------------------------------------------------------  --------
20180215  murder   REDACTED REDACTED REDACTED                                    SQL City

20180215  murder   Someone killed the guard! He took an arrow to the knee!       SQL City

20170712  theft    A lone hunter stalks the night, firing arrows into the Darkn  SQL City
                   ess.                                                                  
                               There is no hiding, no escape. In the distance,           
                   the beast                                                             
                               falters, tethered to the void. The killing blow           
                   comes without                                                         
                               hesitation, without mercy.                                

20170820  arson    Wield the Hammer of Sol with honor, Titan, it is a thing of   SQL City
                               legend, both past and future.                             

20171110  robbery  The Gjallarhorn shoulder-mounted rocket system was forged fr  SQL City
                   om                                                                    
                               the armor of Guardians who fell at the Twilight           
                   Gap. Gifted                                                           
                               to the survivors of that terrible battle, the Gj          
                   allarhorn                                                             
                               is seen as a symbol of honor and survival.                

20180103  bribery  Apparently, Cayde thought it necessary to expose this extrem  SQL City
                   ely                                                                   
                               rare vegetable to a Hive summoning ritual.                

20180115  assault  Hamilton: Lee, do you yield? Burr: You shot him in the side!  SQL City
                    Yes he yields!                                                       

20180115  assault  Report Not Found                                              SQL City

20180115  murder   Security footage shows that there were 2 witnesses. The firs  SQL City
                   t witness lives at the last house on "Northwestern Dr". The           
                   second witness, named Annabel, lives somewhere on "Franklin           
                   Ave".


# Here's the final result of finding the murderer based on SQL City on 15 January 2018
sqlite> SELECT * FROM crime_scene_report
   ...> WHERE city = 'SQL City'
   ...> WHERE date = '20180115'
   ...> ;
Parse error: near "WHERE": syntax error
  * FROM crime_scene_report WHERE city = 'SQL City' WHERE date = '20180115' ;
                                      error here ---^
sqlite> SELECT * FROM crime_scene_report
   ...> WHERE city = 'SQL City'
   ...> AND date = '20180115';
date      type     description                                                   city    
--------  -------  ------------------------------------------------------------  --------
20180115  assault  Hamilton: Lee, do you yield? Burr: You shot him in the side!  SQL City
                    Yes he yields!                                                       

20180115  assault  Report Not Found                                              SQL City

20180115  murder   Security footage shows that there were 2 witnesses. The firs  SQL City
                   t witness lives at the last house on "Northwestern Dr". The           
                   second witness, named Annabel, lives somewhere on "Franklin           
                   Ave". 

# All the data have been showed as the instruction needs
# Congratulations for myself :)

# ALL THE MURDERES HAVE BEEN INSERT AT 5-1-insert.rb FILE.

# Now im trying to find the real villain, last tasks of Ruby Lessons