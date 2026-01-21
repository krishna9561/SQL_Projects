create database  aiims;
use aiims;
select * from billing;
select * from patients;
#  1 List all patients with their age and gender.
select patient_name,gender,age
from patients;

# 2 Find total number of patients registered.
SELECT 
    COUNT(*) AS patient_count
FROM
    patients;
    
#  3 Display unique departments available in the hospital.
select * from departments ;

# 4 Count total doctors working in AIIMS.
select count(*) as doc_count 
from doctors;

# 5 Find patients older than 60 years;
SELECT * FROM patients;

select * 
from patients 
where age >= 60;

# 6 List doctors with more than 10 years of experience
select * from doctors;

select * 
from doctors 
where experience_years>=10;

# 7 Show top 10 most recent admissions
select *
from  visits
order by visit_date desc
limit 10;

# 8 Find total beds available per department
select * from patients;

# Level 2 – Filtering, Sorting, Conditions

# 1 Find patients from a particular state.
select * from patients;
select * from states ;
select p.state_code, s.state_name,count(patient_id)
from patients p
join states s
on p.state_code=s.state_code
group by p.state_code,s.state_name;

# 2 Show patients who visited after 1st Jan 2024.
select * from visits;
select * from patients;
select p.patient_id ,  p.patient_name, v.visit_date 
from patients p
join visits v
on p.patient_id=v.patient_id
where v.visit_date >'2024-01-01'
order by v.visit_date ;

# 3 display all emergency visits.
select * from visits;
select * from patients;
select * from departments;
select * from doctors;
SELECT *
FROM visits
WHERE admitted = 1
AND status = 'Completed';


# 4 List top 10 most recent visits.

select p.patient_id ,p.patient_name,v.visit_date
from patients p
join visits v
on p.patient_id = v.patient_id 
order by v.visit_date desc
limit 10;

# 5 Show visits for a particular department
select * from visits;
select * from departments;
select * from doctors;

select  v.visit_id,
    v.visit_date,
    p.patient_name,
    d.doctor_name,
    dep.department_name
    from visits v
    join patients p
    on v.patient_id=p.patient_id
    join doctors d
    on v.doctor_id= d.doctor_id
    join departments dep
    on d.department_id = dep.department_id ;
    
    ## 6 Find doctors whose experience is greater than 10 years.
    select * from doctors
    where experience_years>=10
    order by experience_years desc;
    
    # 7. Show all visits with consultation fee greater than ₹1000.
   select * from visits;
   select * from patients;
   select v.visit_id ,d.consultation_fee,p.patient_id ,p.patient_name
    from doctors d
    join visits v
    on d.doctor_id = v.doctor_id
    join patients p
    on v.patient_id = p.patient_id 
    where d.consultation_fee>1000
    order by d.consultation_fee desc;

     # 8 Display all  bills
     select * from billing;
     select * from insurance_claims;
     select * from districts;
     
select * from  billing 
where payment_mode = 'Card';


 ## 9 Sort patients by age in descending order
 select * from patients
 order by age desc ;
 
  #####  🔹 Level 3 – Aggregation & GROUP BY
  # 1 Count how many patients are in each state
  select * from patients;
  select count(patient_id)as coount,state_code
  from patients
  group by state_code
  order by  coount desc;
  
  
  # 2 Find total revenue from billing.
  select * from billing;
  select sum(treatment_cost) as sum_cost
  from billing;
  
  # 3 Find average bill amount
  select round(avg(treatment_cost),2)as avg_cost
  from billing;
  
  # 4 Find department-wise revenue.
  select * from billing;
select * from departments;
select * from visits;
select * from doctors;



select department_name,sum(treatment_cost) as cost 
from visits v
join billing b
on v.visit_id = b.visit_id
join doctors d
on d.doctor_id = v.doctor_id
join departments dep
on d.department_id=dep.department_id
group by department_name
order by cost desc;

# 5 Find number of visits per doctor
select * from visits;
select * from doctors;

select d.doctor_id ,d.doctor_name, count(v.visit_id) as coount 
from visits 
group by doctor_id,d.doctor_name
order by coount desc;

# 6 Find state-wise patient count
select * from states;
select * from patients;
select s.state_code,s.state_name,count(p.patient_id) as patient_count
from patients p
join states s
on p.state_code=s.state_code
group by state_code,s.state_name 
order by patient_count desc;


# 7 Show insurance company wise number of claims.
select * from insurance_claims;
select count(claim_id) as claim_status ,provider
from insurance_claims
group by provider
order by claim_status;

# 8 Find max, min, avg bill amount.
select * from billing;
select min(treatment_cost) as min_bill,max(treatment_cost) as max_bill,round(avg(treatment_cost),2)as avg_bill
from billing;
 
 # 9 Find how many patients visited more than once
 select p.patient_id,p.patient_name,count(v.visit_id)  as coount
from patients p
join	visits v
on v.patient_id = p.patient_id
group by p.patient_id ,p.patient_name 
having count(visit_id)>1
order by coount desc ;

# 🔹 Level 4 – Joins (Core Data Analyst Skill)
# 1 Show patient name with their visit date.
select * from patients;
select * from visits;
select p.patient_name,v.visit_date
from visits v
join patients p
on p.patient_id = v.patient_id
order by p.patient_name;

# 2 Show doctor name and patient name for each visit
select * from doctors;
select * from patients;
select * from visits;
select d.doctor_name , p.patient_name 
from visits v
join patients p
on v.patient_id = p.patient_id 
join doctors d 
on d.doctor_id = v.doctor_id;

# 3  Show department name for every visit.
select * from departments;
select * from visits ;
select * from doctors;
select dep.department_name,count(v.visit_id) as count_visit
from visits v
join doctors d
 on v.doctor_id = d.doctor_id 
 join departments dep
on d.department_id=dep.department_id
 group by dep.department_name ;
 
 # 4 “How many visits happened in each department”
 select dep.department_name,count(v.visit_id) as count_visit
from visits v
join doctors d
 on v.doctor_id = d.doctor_id 
 join departments dep
on d.department_id=dep.department_id
 group by dep.department_name ;
 
 # 5 Show patient, doctor, and bill amount. 
 select * from billing;
 select * from doctors;
 select * from patients;
 select * from visits;
 select p.patient_name ,di.doctor_name ,b.treatment_cost
 from  visits v
 join billing b
 on v.visit_id = b.visit_id
 join doctors di
 on v.doctor_id= di.doctor_id
 join patients p
 on v.patient_id = p.patient_id ;
 
 # 6  Find total bill amount per patient.
 select * from billing;
 select * from patients;
 select * from visits;

 select p.patient_id , p.patient_name , sum(b.treatment_cost) as treatment_cost
 from visits v
 join patients p 
 on v.patient_id = p.patient_id
 join billing b
 on v.visit_id=b.visit_id
 group by p.patient_id , p.patient_name 
 order by treatment_cost desc;
 
 # 7 show insurance provider for each patient.
 
 select * from insurance_claims;
 select * from patients;
 select * from billing;
 select * from visits;
 
 
 
select p.* , i.provider
from insurance_claims i
join billing b
on i.bill_id = b.bill_id 
join visits v
on b.visit_id = v.visit_id 
join patients p
on p.patient_id = v.patient_id ; 

# 8 Find state name of each patient.
select * from states;
select * from patients;

select p.* ,s.state_name
from patients p
join states s
on p.state_code= s.state_code;

# 9 Find patients who never made a visit.
select * from patients;
select * from visits;
select p.* 
from patients p 
left join visits v
 on p.patient_id= v.patient_id 
 where v.visit_id is null;
 
 # 10 Show doctor and their department.
 
 select * from doctors;
 select * from departments;
 
 select d.* ,de.department_name
 from doctors d
 join departments de 
 on d. department_id= de.department_id;
 
 
##  🔹 Level 5 – Subqueries & Case Logic

 # 1 Find patients who paid more than average bill amount.
 select * from patients;
 select * from billing;
 select * from visits;
select p.* ,b.treatment_cost 
from patients p
join visits v
on p.patient_id=v.patient_id 
join billing b
on b.visit_id= v.visit_id
where b.treatment_cost >( select avg(treatment_cost )  from billing);


with avg_treat as (select p.patient_name ,avg(b.treatment_cost) as avg_treat_cost 
from patients p
join visits v
on p.patient_id=v.patient_id 
join billing b
on b.visit_id= v.visit_id
group by p.patient_name)
select  patient_name , avg_treat_cost 
from avg_treat 
where  avg_treat_cost> (select avg(treatment_cost)from billing)  ;



# 2 . Find doctors who handled more than 50 visits.
select * from doctors;
select * from visits;

select * 
from doctors 
where doctor_id in ( select doctor_id 
from visits 
group by doctor_id
having count(visit_id )>50 );




# 3 Find departments with revenue above average.

select * from departments;
select * from billing;
select * from visits;
select * from doctors;



select d.department_name , sum(b.treatment_cost) as treat_cost
from departments d 
join doctors dr
on d.department_id = dr.department_id 
join visits v  
on v.doctor_id= dr.doctor_id 
join billing b
on v.visit_id = b.visit_id 
group by d.department_name  
having sum(b.treatment_cost )> ( select avg(dep_total)
from ( select sum(b.treatment_cost ) as dep_total
from departments d 
join doctors dr
on d.department_id = dr.department_id 
join visits v  
on v.doctor_id= dr.doctor_id 
join billing b
on v.visit_id = b.visit_id 
group by d.department_id ) t)  ;