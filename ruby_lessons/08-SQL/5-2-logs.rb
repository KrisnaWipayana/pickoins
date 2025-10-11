# Here's the interview result based on showed data on 5-1.rb, the witnesses says:

# I was hired by a woman with a lot of money. I don't know her
# name but I know she's around 5'5" (65") or 5'7" (67"). She 
# has red hair and she drives a Tesla Model S. I know that she
# attended the SQL Symphony Concert 3 times in December 2017.

# Lets find that people who has the same info
sqlite> select * from person
   ...> join drivers_license on person.license_id = drivers_license.id
   ...> where hair_color = 'red'
   ...> and drivers_license.height between 65 and 67
   ...> and drivers_license.car_make = 'Tesla'
   ...> and drivers_license.car_model = 'Model S';
id     name              license_id  address_number  address_street_name  ssn        id      age  height  eye_color  hair_color  gender  plate_number  car_make  car_model
-----  ----------------  ----------  --------------  -------------------  ---------  ------  ---  ------  ---------  ----------  ------  ------------  --------  ---------
78881  Red Korb          918773      107             Camerata Dr          961388910  918773  48   65      black      red         female  917UU3        Tesla     Model S  
90700  Regina George     291182      332             Maple Ave            337169072  291182  65   66      blue       red         female  08CM64        Tesla     Model S  
99716  Miranda Priestly  202298      1883            Golden Ave           987756388  202298  68   66      green      red         female  500123        Tesla     Model S

# Looking for the event with attendant 3 times in December 2017
sqlite> select person_id, count(*) as count from city_event_checkin
   ...> where event_name = 'SQL Symphony Concert'
   ...> and date between 20171201 and 20171231
   ...> group by person_id
   ...> ;
person_id  count
---------  -----
11173      1    
19260      1    
19292      1    
24397      1    
24556      3    
28582      2    
43366      1    
58898      1    
62596      1    
67318      1    
69325      1    
69699      1    
79312      1    
81526      1    
92343      1    
99716      3
# There was 2 person who comes to the event 3 times, the first one is Bryan Padro
sqlite> select * from person
   ...> where id = '24556';
id     name         license_id  address_number  address_street_name  ssn      
-----  -----------  ----------  --------------  -------------------  ---------
24556  Bryan Pardo  101191      703             Machine Ln           816663882
# But the information given from witnesses said the real villain was a woman because the witnesses say with "she" pronounce

# And.. we find the real villain was Miranda Priestly with person_id 99716.
sqlite> select * from person
   ...> where id = '99716';
id     name              license_id  address_number  address_street_name  ssn      
-----  ----------------  ----------  --------------  -------------------  ---------
99716  Miranda Priestly  202298      1883            Golden Ave           987756388

# Next, lets see the transcript of the interview
sqlite> select * from interview
   ...> where person_id = '99716';
sqlite> select * from interview
   ...> where person_id = '99716';
# There was no data about the interview? it was strange but i couldn't find the transcript