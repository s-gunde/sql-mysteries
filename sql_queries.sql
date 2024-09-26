/* A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database

Exploring the Database Structure
Experienced SQL users can often use database queries to infer the structure of a database. But each database system has different ways of managing this information. The SQL Murder Mystery is built using SQLite. Use this SQL command to find the tables in the Murder Mystery database.*/

SELECT name 
  FROM sqlite_master
 where type = 'table'


--name
crime_scene_report
drivers_license
person
facebook_event_checkin
interview
get_fit_now_member
get_fit_now_check_in
income
solution



 /* As per initial statement released by police department about the crime details:  the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City and we will start our investigation from here */

 SELECT sql 
  FROM sqlite_master
 where name = 'crime_scene_report'

sql
CREATE TABLE crime_scene_report (
        date integer,
        type text,
        description text,
        city text
    )


SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND city = 'SQL City' AND type = 'murder'

date	type	description	city
20180115	murder	Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".	SQL City


/* Here comes the second clue in "description" : there are 2 witnesses for the crime and we have their addresses to investigate further by seeing their responses for interviews conducted by police
but before that we need to find the name of these 2 witnesses and their IDs to see the interviews*/

SELECT DISTINCT id,name, address_number, address_street_name
FROM person
WHERE ( address_street_name LIKE '%Northwestern Dr%'
  OR address_street_name LIKE '%Franklin Ave%' AND name LIKE '%Annabel%' )
ORDER BY address_number DESC -- gives last house number lives in Northwestern Dr

id	name	address_number	address_street_name
14887	Morty Schapiro	4919	Northwestern Dr
17729	Lasonya Wildey	3824	Northwestern Dr
53890	Sophie Tiberio	3755	Northwestern Dr
73368	Torie Thalmann	3697	Northwestern Dr
96595	Coretta Cubie	3631	Northwestern Dr
19420	Cody Schiel	3524	Northwestern Dr
93509	Emmitt Aceuedo	3491	Northwestern Dr
87456	Leonora Wolfsberger	3483	Northwestern Dr
36378	Freddie Ellzey	3449	Northwestern Dr
53076	Boris Bijou	3327	Northwestern Dr
28360	Rashad Cascone	3212	Northwestern Dr
23044	Val Portlock	3143	Northwestern Dr
51114	Christena Saffell	3055	Northwestern Dr
68690	Yer Modest	3046	Northwestern Dr
44004	Alison Eska	2951	Northwestern Dr
98593	Jonah Toner	2947	Northwestern Dr
59307	Cyril Yongue	2903	Northwestern Dr
34155	Allyson Lazenson	2840	Northwestern Dr
90397	Dionna Kranwinkle	2678	Northwestern Dr
54564	Sammie Sengun	2590	Northwestern Dr
53699	Christian Pagano	2585	Northwestern Dr
34352	Vincenza Burkhardt	2512	Northwestern Dr
80921	Donovan Yackley	2386	Northwestern Dr
96178	Galina Khuu	2183	Northwestern Dr
81885	Kurtis Masuda	2108	Northwestern Dr
88423	Teri Ehrich	1879	Northwestern Dr
51552	Bonita Knie	1726	Northwestern Dr
72076	Courtney Bordeaux	1707	Northwestern Dr
81052	Calvin Czelusniak	1516	Northwestern Dr
71924	Laurie Scronce	1418	Northwestern Dr
23960	Kristopher Lagerberg	1392	Northwestern Dr
70485	Andera Kostelecky	1252	Northwestern Dr
22239	Dusty Sigafus	1125	Northwestern Dr
18376	Josh Shi	1091	Northwestern Dr
29608	Willetta Lurvey	1028	Northwestern Dr
33415	Homer Simpson	981	Northwestern Dr
55130	Shiloh Huntoon	951	Northwestern Dr
44542	Ivory Mcgrevey	897	Northwestern Dr
99826	Ivy Kazarian	892	Northwestern Dr
25615	Olevia Morena	812	Northwestern Dr
40760	Renata Faver	745	Northwestern Dr
10010	Muoi Cary	741	Northwestern Dr
39688	Abe Roeker	689	Northwestern Dr
26758	Angelena Billman	629	Northwestern Dr
75484	Del Tacderen	607	Northwestern Dr
12711	Norman Apolito	599	Northwestern Dr
85280	Donn Duin	540	Northwestern Dr
40336	Fredia Billeter	404	Northwestern Dr
15171	Weldon Penso	311	Northwestern Dr
89906	Kinsey Erickson	309	Northwestern Dr
16371	Annabel Miller	103	Franklin Ave


/* Found the 2 witnesses which are having IDs: 14887 and 16371 */
SELECT *
FROM interview
WHERE person_id IN ( 14887, 16371)

person_id	transcript
14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

SELECT *
FROM get_fit_now_member
JOIN get_fit_now_check_in
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE membership_status LIKE '%gold%'
AND membership_id LIKE '48Z%'
AND check_in_date = 20180109

id	person_id	name	membership_start_date	membership_status	membership_id	check_in_date	check_in_time	check_out_time
48Z7A	28819	Joe Germuska	20160305	gold	48Z7A	20180109	1600	1730
48Z55	67318	Jeremy Bowers	20160101	gold	48Z55	20180109	1530	1700


SELECT *
FROM drivers_license
JOIN person
ON drivers_license.id = person.license_id
WHERE person.id IN ( 28819, 67318)
AND plate_number LIKE '%H42W%'

id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model	id	name	license_id	address_number	address_street_name	ssn
423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS	67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279

SELECT *
FROM drivers_license
JOIN person
ON drivers_license.id = person.license_id
JOIN facebook_event_checkin
ON person.id = facebook_event_checkin.person_id
WHERE height >= 65 AND height <= 67
AND hair_color LIKE '%Red%'
AND car_make LIKE '%Tesla%'
AND car_model LIKE '%S%'
AND event_name LIKE '%SQL Symphony%'
AND date >= 20171201 AND date < 20180101

id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model	id	name	license_id	address_number	address_street_name	ssn	person_id	event_id	event_name	date
202298	68	66	green	red	female	500123	Tesla	Model S	99716	Miranda Priestly	202298	1883	Golden Ave	987756388	99716	1143	SQL Symphony Concert	20171206
202298	68	66	green	red	female	500123	Tesla	Model S	99716	Miranda Priestly	202298	1883	Golden Ave	987756388	99716	1143	SQL Symphony Concert	20171212
202298	68	66	green	red	female	500123	Tesla	Model S	99716	Miranda Priestly	202298	1883	Golden Ave	987756388	99716	1143	SQL Symphony Concert	20171229


INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;

value
Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!