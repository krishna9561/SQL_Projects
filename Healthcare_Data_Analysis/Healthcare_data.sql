create database hospital_data;
select * from  disease_hospital_map;
select * from hospital_master;
select * from patient_master;
select * from patient_ratings;
select * from visit_record;

#  1. Show all records from patient_master
select * from patient_master;
# 2.Show the Name and City of all patients.
select Name ,city
from patient_master;
# 3.Show all hospitals in Pune.
select * 
from hospital_master
where city like '%Pune%';
# 4 Show diseases treated in each hospital.
select HospitalName,Disease
from hospital_master hm
join disease_hospital_map dm
on hm.Specialization=dm.Specialization;

# 5 . Count how many patients are from Mumbai.
select * from patient_master;
select count(patientid) as patient_count
from patient_master;

# 6 List all male patients.
select * 
from patient_master
where gender like '%M%';

# 7 ow hospitals with a rating greater than 4
select * from hospital_master;
select * 
from hospital_master
where Rating>4
order by Rating;

# 8 Show the total number of hospitals.
select count(*)
from hospital_master;

# 9 Show unique diseases from patient_master
select * from patient_master;
select distinct(disease)
from patient_master;


## 10 Show all visits from visit_record.
select * from visit_record;

#  11 Show the highest hospital rating.
select max(rating)
from hospital_master;

# 12 Show the lowest hospital rating.
select min(rating)
from hospital_master;

# 13 Show all visits happened on a specific date
select * from visit_record;

select * 
from visit_record
where VisitDate='2024-03-02';

## 14 Show the patient details whose PatientID = 10.
select * from patient_master
where PatientID='P010';

# 15 Show hospital names and their cities.
select HospitalName,city 
from hospital_master;



# -> intermediate <-#

# 16 Count patients grouped by city.
select * from patient_master;
select count(*) as count_patient,city
from patient_master
group by city
order by count_patient desc;

# 17 Count hospitals by specialization.
select * from hospital_master;
select count(*) as count_hosp,specialization
from hospital_master
group by Specialization
order by count_hosp desc;

#  18 Show hospitals that treat ‘Cardiac’ disease (use join)
select hm.hospitalname,dh.disease
from hospital_master hm
join disease_hospital_map dh
on hm.Specialization=dh.Specialization
where dh.Specialization like '%cardiology%';


#  19 . Show patients with their visited hospital name
select * from patient_master;
select * from visit_record;
select * from hospital_master;

select pm.*,hm.hospitalname
from visit_record vr
join patient_master pm 
on  vr.PatientID =pm.PatientID
join hospital_master hm
on vr.HospitalID = hm.HospitalID;

# 20 . Find patients who visited more than 1 time
select * from patient_master;
select * from visit_record;
select pm.PatientID ,count(vr.visitid) as count_visit 
from patient_master pm
join visit_record vr 
on pm.PatientID=vr.PatientID
group by pm.PatientID
having count(vr.VisitID)>1;

# 21.Find hospitals whose rating is between 3 and 5.

select * from hospital_master;
select * 
from hospital_master 
where Rating >=3 and Rating<=5
order by Rating desc;

# 22 Show the top 5 patients based on age.
select * 
from patient_master
order by age desc
limit 5;


# 23 Show hospital details along with diseases they treat 
select * from hospital_master;
select * from disease_hospital_map;

select hm.*,dh.disease
from hospital_master hm
join disease_hospital_map dh
on hm.Specialization=dh.Specialization;

# 24 Find which disease is most common among patients.
select * from patient_master;

select count(disease)as disease_count ,Disease
from patient_master
group by Disease
order by disease_count desc
limit 1;

# 25 Find total bills generated for all visits.
select * from visit_record;

select sum(totalbill) as sum_bill
from visit_record;

# 26 Show visit dates along with hospital and patient name
select * from patient_master;
select * from visit_record;

select pm.name,vr.visitdate
from patient_master pm 
join visit_record vr
on pm.PatientID=vr.PatientID;

# 27 Show all hospitals that treat more than 2 diseases.
select hm.HospitalName,count(dm.Disease) as count_dis
from hospital_master hm
join disease_hospital_map dm
on hm.Specialization=dm.Specialization
group by hm.HospitalName
having count(dm.Disease)>1; 

# 28 List patients who visited a specific hospital

select * from patient_master;
select * from visit_record;
select * from hospital_master;

select distinct(hm.hospitalname),pm.*
from visit_record vr
join patient_master pm 
on  vr.PatientID =pm.PatientID
join hospital_master hm
on vr.HospitalID = hm.HospitalID
where hm.HospitalName ='Hospital_20';

  # 29 Show all patient's latest visit.
  
select pm.*,vr.visitdate
from visit_record vr
join patient_master pm 
on  vr.PatientID =pm.PatientID
order by vr.VisitDate desc
limit 10;

# 30 Count number of patients by gender 
select * from patient_master;
select count(gender) as count_gender,gender 
from patient_master
group by gender;

# 31 Show all patients who have not visited any hospital (LEFT JOIN)
select * from hospital_master;

select pm.* 
from visit_record vr
join patient_master pm 
on  vr.PatientID =pm.PatientID
 left join hospital_master hm
on vr.HospitalID = hm.HospitalID
where vr.VisitID is null;

# 32 Show hospitals without any visits.
select hm.* 
from hospital_master hm 
join visit_record vr
on hm.HospitalID=vr.HospitalID
where vr.VisitID is null;



# 33 Show total visits per hospital.
select * from hospital_master;
select * from visit_record;

select hm.HospitalID,hm.HospitalName,count(vr.visitid) as visit_count
from hospital_master hm
join visit_record vr
on hm.HospitalID=vr.HospitalID
group by hm.HospitalID,hm.HospitalName
order by visit_count desc;


# 34 show records of patients aged between 20 and 40

select * from patient_master;

select * 
from patient_master
where age >=20 and age <=40
order by age desc ;

## 35 Find hospitals in each city (GROUP BY city)
select city,count(HospitalID)
from hospital_master
group by city;




## ------> ADVANCE LEVEL <--------- ##



# 36 Show top 3 hospitals for each disease (WINDOW FUNCTION).
select *  from hospital_master;

select * from(select hm.hospitalname ,
dense_rank() over (partition by dm.Disease order by hm.rating desc) as hdata
from hospital_master hm
join disease_hospital_map  dm
on hm.Specialization=dm.Specialization) as t
where hdata<=3;


# 37 Show total revenue earned by each hospital.
select * from hospital_master;
select * from visit_record;

select hm.hospitalid,hm.hospitalname,sum(vr.TotalBill) as revenue
from hospital_master hm 
 join visit_record vr 
 where hm.HospitalID=vr.HospitalID
 group by hm.hospitalid,hm.hospitalname
 order by revenue desc;
 
 
 # 38 find which hospital has the maximum number of visits
 select HospitalName,count(VisitID) as coount
 from hospital_master hm 
 join visit_record vr 
 where hm.HospitalID=vr.HospitalID
 group by HospitalName
 order by coount desc
 limit 5;
 
 # 39 Find which hospital earns the highest revenue
 
 select hm.hospitalid,hm.hospitalname,sum(vr.TotalBill) as revenue
from hospital_master hm 
 join visit_record vr 
 where hm.HospitalID=vr.HospitalID
 group by hm.hospitalid,hm.hospitalname
 order by revenue desc
 limit 1;
 
 
 # 40 Find the average bill amount per disease
 select * from visit_record;
 select * from patient_master;
 
 
 select disease,avg(totalbill)as avgg
 from patient_master pm 
 join visit_record vr
 on pm.PatientID=vr.PatientID
 group by Disease;
 
 
 # 41 Show patient’s full visit history with hospital rating
 
 select pm.* ,hm.rating
 from hospital_master hm
 join visit_record vr
 on hm.HospitalID=vr.HospitalID
 join patient_master pm
 on vr.PatientID=pm.PatientID;
 
 
 # 42 Detect patients who visited multiple hospitals.
select  pm.PatientID,pm.Name,
    COUNT(DISTINCT vr.HospitalID) AS hospitals_visited
from patient_master pm 
join visit_record vr
on  pm.PatientID=vr. PatientID 
group by pm.PatientID,pm.Name
having hospitals_visited >1;


# 43 For each city, show the best-rated hospital.
select * from hospital_master;

select city,hospitalname,max(rating) as max_rating 
from hospital_master
group by city,hospitalname
order by max_rating desc;


# 44 Show diseases ranked by number of patients (RANK()).
 select * from patient_master;
 
 select name,disease,count(PatientID) as coount,
 rank() over (order by count(PatientID) desc) as raank
 from patient_master
 group by Disease,name;
 
 # 45 Show hospitals ranked by revenue.
 
 select * from hospital_master;
 select * from visit_record;
 with revenue_cte as (
 select hm.HospitalName,sum(vr.totalbill)as revenue
 from hospital_master hm 
 join visit_record vr
 on vr.hospitalid= hm.hospitalid
 group by hm.HospitalName
 ) 
 select HospitalName,revenue,
 rank() over (order by revenue desc) as raank
 from revenue_cte;
 
 
 # 46 Show patient count growth month-wise (DATE functions)
 
 select * from visit_record;
 select month(visitdate)as moonth,count(patientid)as patitent_count
 from visit_record
 group by month(visitdate)
 order by moonth;
 
 # 47 Find which specialization has the highest rated hospitals.
 select * from hospital_master;
 
 select Specialization ,rating
 from hospital_master
 where Rating=(select max(Rating) from hospital_master);
 
 # 48 Show the hospital that treats most diseases, with count.
select hospitalname,count(disease) as count_disease
from hospital_master hm
join disease_hospital_map dm
on hm.Specialization=dm.Specialization 
group by HospitalName 
order by count_disease desc
limit 2;

# 49 Identify patients who always visit the same hospital.

select * from patient_master;
select * from visit_record;


select  pm.name ,count(distinct(vr.hospitalid))as id 
from patient_master pm
join visit_record vr
on pm.PatientID=vr.PatientID
group by pm.name
order by id desc ;

#  50 Create a VIEW that shows patient name, hospital name, visit date, bill amount
create View krishna as select pm.name,hm.hospitalname,vr.visitdate,vr.TotalBill
from hospital_master hm
 join visit_record vr
 on hm.HospitalID=vr.HospitalID
 join patient_master pm
 on vr.PatientID=pm.PatientID;
 
 select * from krishna;
 
 
 
 
 # 51 Show top 2 hospitals in each city
 select * from hospital_master;
 with city_rank as ( 
 select  hospitalid ,hospitalname,city,rating,
 row_number()over (partition by city order by rating desc ) as raank
 from hospital_master)
 select   hospitalid ,hospitalname,city,rating,raank
 from city_rank
 where raank<=2;
