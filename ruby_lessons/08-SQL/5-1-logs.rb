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
sum@sum-HP-Laptop-14-em0xxx:~/Projects/ruby_lessons/08-SQL$ sqlite3
SQLite version 3.45.1 2024-01-30 16:01:20
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open police-database.dbs
sqlite> .mode column
sqlite> .headers on
sqlite> select * from crime_scene_report
   ...> where city = 'SQL City'
   ...> and date = '20180115'
   ...> and type = 'murder';
date      type    description                                                   city    
--------  ------  ------------------------------------------------------------  --------
20180115  murder  Security footage shows that there were 2 witnesses. The firs  SQL City
                  t witness lives at the last house on "Northwestern Dr". The           
                  second witness, named Annabel, lives somewhere on "Franklin           
                  Ave".
# Now we got some information by the description showed, i need to find people who lives at Northwestern Dr and Annabel Franklin Ave                  

# Filtering people who lives at the last house on Northwestern Dr
sqlite> select * from person
   ...> where address_street_name = 'Northwestern Dr'
   ...> order by address_number desc;
id     name                  license_id  address_number  address_street_name  ssn      
-----  --------------------  ----------  --------------  -------------------  ---------
14887  Morty Schapiro        118009      4919            Northwestern Dr      111564949

# Filtering people who lives at Franklin Ave named Annabel
sqlite> select * from person
   ...> where address_street_name = 'Franklin Ave'
   ...> and name like '%Annabel%';
id     name            license_id  address_number  address_street_name  ssn      
-----  --------------  ----------  --------------  -------------------  ---------
16371  Annabel Miller  490173      103             Franklin Ave         318771143
sqlite> 

# Getting the person_id so i can access the interview data
sqlite> select * from get_fit_now_member
   ...> where name = 'Annabel Miller';
id     person_id  name            membership_start_date  membership_status
-----  ---------  --------------  ---------------------  -----------------
90081  16371      Annabel Miller  20160208               gold  

# And the interview, Annabel says:
sqlite> select * from interview
   ...> where person_id = '16371';
person_id  transcript                                                  
---------  ------------------------------------------------------------
16371      I saw the murder happen, and I recognized the killer from my
            gym when I was working out last week on January the 9th.  

# Showing all the gym members at 9th January
sqlite> select * from get_fit_now_check_in
   ...> where check_in_date = '20180109';
membership_id  check_in_date  check_in_time  check_out_time
-------------  -------------  -------------  --------------
X0643          20180109       957            1164          
UK1F2          20180109       344            518           
XTE42          20180109       486            1124          
1AE2H          20180109       461            944           
6LSTG          20180109       399            515           
7MWHJ          20180109       273            885           
GE5Q8          20180109       367            959           
48Z7A          20180109       1600           1730          
48Z55          20180109       1530           1700          
90081          20180109       1600           1700

# Finding the suspicious membership
sqlite> select * from get_fit_now_member
   ...> join get_fit_now_check_in
   ...> on get_fit_now_member.id = get_fit_now_check_in.membership_id
   ...> where get_fit_now_check_in.check_in_date = '20180109';
id     person_id  name               membership_start_date  membership_status  membership_id  check_in_date  check_in_time  check_out_time
-----  ---------  -----------------  ---------------------  -----------------  -------------  -------------  -------------  --------------
X0643  15247      Shondra Ledlow     20170521               silver             X0643          20180109       957            1164          
UK1F2  28073      Zackary Cabotage   20170818               silver             UK1F2          20180109       344            518           
XTE42  55662      Sarita Bartosh     20170524               gold               XTE42          20180109       486            1124          
1AE2H  10815      Adriane Pelligra   20170816               silver             1AE2H          20180109       461            944           
6LSTG  83186      Burton Grippe      20170214               gold               6LSTG          20180109       399            515           
7MWHJ  31523      Blossom Crescenzo  20180309               regular            7MWHJ          20180109       273            885           
GE5Q8  92736      Carmen Dimick      20170618               gold               GE5Q8          20180109       367            959           
48Z7A  28819      Joe Germuska       20160305               gold               48Z7A          20180109       1600           1730          
48Z55  67318      Jeremy Bowers      20160101               gold               48Z55          20180109       1530           1700          
90081  16371      Annabel Miller     20160208               gold               90081          20180109       1600           1700

# Looked up for the interview
sqlite> select * from interview
   ...> WHERE person_id IN (28819, 67318);
person_id  transcript                                                  
---------  ------------------------------------------------------------
67318      I was hired by a woman with a lot of money. I don't know her
            name but I know she's around 5'5" (65") or 5'7" (67"). She 
           has red hair and she drives a Tesla Model S. I know that she
            attended the SQL Symphony Concert 3 times in December 2017.

# The murderer have been found, i'm doing the sql insert at 5-1.rb file
# Now im trying to find the real villain, last tasks of Ruby Lessons