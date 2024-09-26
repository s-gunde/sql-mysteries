
🕵️‍♂️ **A Crime Has Occurred**:

A crime has taken place, and the detective needs your help. The detective provided you with the crime scene report, but unfortunately, you’ve misplaced it. You vaguely remember that the crime was a **murder** that occurred on **January 15, 2018**, in **SQL City**.

📋 Your first task is to retrieve the crime scene report from the police department's database.

## 🗂️ Exploring the Database Structure:
Experienced SQL users often infer the structure of a database using queries. However, each database system stores this information differently. The **SQL Murder Mystery** is built using **SQLite**.

🛠️ Use the following SQL command to discover the tables in the Murder Mystery database:

*SELECT name 
FROM sqlite_master
WHERE type = 'table'*

**name**
- crime_scene_report
- drivers_license
- person
- facebook_event_checkin
- interview
- get_fit_now_member
- get_fit_now_check_in
- income
- solution

🕵️‍♂️ **Initial Crime Statement**:

According to the police department's statement, the crime was a **murder** that took place on **January 15, 2018**, in **SQL City**.

🚨 We will begin our investigation based on this information.


 *SELECT sql 
  FROM sqlite_master
 where name = 'crime_scene_report'*
 
**sql**

CREATE TABLE crime_scene_report (
        date integer,
        type text,
        description text,
        city text
    )

*SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND city = 'SQL City' AND type = 'murder'*

🔍 **Second Clue Uncovered**:

In the "description," we learn that there are **2 witnesses** to the crime. We have their **addresses** and will investigate further by reviewing their responses to the police interviews. 

📝 But before we proceed, we need to find the **names** and **IDs** of these 2 witnesses in order to access the interviews.

*SELECT DISTINCT id,name, address_number, address_street_name
FROM person
WHERE ( address_street_name LIKE '%Northwestern Dr%'
  OR address_street_name LIKE '%Franklin Ave%' AND name LIKE '%Annabel%' )
ORDER BY address_number DESC -- gives last house number lives in Northwestern Dr*

✅ **Witnesses Identified**:

We have located the **two witnesses** involved in the case. Their witness IDs are:

- 🆔 **14887**
- 🆔 **16371**
  

*SELECT *
FROM interview
WHERE person_id IN ( 14887, 16371)*


📝 **Witness Testimony**:

According to the transcripts, the witnesses reported seeing a man associated with **"Get Fit Now Gym"**. He is identified as a **Gold Member** due to his gym bag and membership ID. The man was last seen at the gym. 🏋️‍♂️

🎥 Here's what we know so far:

*SELECT *
FROM get_fit_now_member
JOIN get_fit_now_check_in
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE membership_status LIKE '%gold%'
AND membership_id LIKE '48Z%'
AND check_in_date = 20180109*


🔍 **Suspect Matches**:

Based on the above criteria, we have identified **2 potential matches**. However, there's another clue: the murderer owns a car with the license plate **H42W**. 🚗🔑

*SELECT *
FROM drivers_license
JOIN person
ON drivers_license.id = person.license_id
WHERE person.id IN ( 28819, 67318)
AND plate_number LIKE '%H42W%'*

🎉 **Woohoo! We Got the Killer!** 🎉

After following all the clues, we've finally identified the **KILLER**! 🕵️‍♂️🚨

![Victory GIF](https://media.giphy.com/media/3o6Zt8MgUuvSbkZYWc/giphy.gif) <!-- Example GIF for celebration -->


*INSERT INTO solution VALUES (1, 'Jeremy Bowers')
        SELECT value FROM solution*

🎉 **Congratulations! You Found the Murderer!** 🎉

But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to uncover the real villain behind this crime. 🕵️‍♂️

💪 If you feel especially confident in your SQL skills, attempt to complete this final step with no more than **2 queries**. Use the same **INSERT** statement with your new suspect to verify your answer. 🔍

🔍 **Need to Check the Killer's Statements About the Murder**:


*SELECT *
FROM interview
WHERE person_id = 67318*

With all the descriptions provided by the KILLER, queried below:

*SELECT *
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
AND date >= 20171201 AND date < 20180101*


🎉 **Woohoo! This Time, Let's See** 👀


*INSERT INTO solution VALUES (1, 'Miranda Priestly');
        SELECT value FROM solution;*

🥳 **Congratulations!** 🎉

You found the brains behind the murder! Everyone in **SQL City** hails you as the greatest SQL detective of all time. 🍾 Time to break out the champagne! 


**MURDERER:** *Miranda Priestly*
