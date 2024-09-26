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
