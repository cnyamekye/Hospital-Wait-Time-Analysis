-- EXPLORATORY DATA ANALYSIS(EDA)

-- Patient distribution by department
select Department, count(Patient_ID) as Number_of_Patients
from hospital_wait_times_3
group by Department
order by Number_of_Patients;

-- Count missing values per column
select 
   count(*) - count(Patient_ID) as Null_Patient_ID,
   count(*) - count(Age) as Null_Age,
   count(*) - count(Gender) as Null_Gender,
   count(*) - count(Department) as Null_Department,
   count(*) - count(Arrival_Date) as Null_Arrival_Date,
   count(*) - count(Appointment_Date) as Null_Appointment_Date,
   count(*) - count(Consultation_Date) as Null_Consultation_Date,
   count(*) - count(Arrival_Time) as Null_Arrival_Time,
   count(*) - count(Appointment_Time) as Null_Appointment_Time,
   count(*) - count(Consultation_Start) as Null_Consultation_Start,
   count(*) - count(Wait_Time) as Null_Wait_Time,
   count(*) - count(Appointment_Type) as Null_Appointment_Type,
   count(*) - count(Visit_Status) as Null_Visit_Status,
   count(*) - count(Visit_Day) as Null_Visit_Day,
   count(*) - count(Notes) as Null_Notes,
   count(*) - count(Temp_Field) as Null_Temp_Field
from hospital_wait_times_3;

-- Gender distribution
select Gender, count(Gender) as Gender_Count
from hospital_wait_times_3
group by Gender
order by Gender_Count desc;

-- Wait time stats overall
select avg(Wait_Time) as Average_Wait_Time,
       min(Wait_Time) as Minimum_Wait_Time,
       max(Wait_Time) as Maximum_Wait_Time
from hospital_wait_times_3;

-- Department visit frequency
select Department, count(Department) as Department_Count
from hospital_wait_times_3
group by Department
order by Department_Count desc;

-- Appointment type distribution
select Appointment_Type, count(Appointment_Type) as Appointment_Count
from hospital_wait_times_3
group by Appointment_Type
order by Appointment_Count desc;

-- Wait time stats by day of visit
select Visit_Day, avg(Wait_Time) as Average_Wait_Time, 
       min(Wait_Time) as Minimum_Wait_Time, 
       max(Wait_Time) as Maximum_Wait_Time
from hospital_wait_times_3
group by Visit_Day
order by Visit_Day;

-- Patient count by visit day
select Visit_Day, count(Visit_Day) as Visit_Day_Count
from hospital_wait_times_3
group by Visit_Day
order by Visit_Day_Count desc;

-- Age stats overall
select avg(Age) as Average_Age, min(Age) as Youngest, max(Age) as Oldest
from hospital_wait_times_3;

-- Notes frequency
select Notes, count(Notes) as Notes_Count
from hospital_wait_times_3
group by Notes
order by Notes_Count desc;

-- Age stats by department
select Department, avg(Age) as Average_Age, min(Age) as Youngest, max(Age) as Oldest
from hospital_wait_times_3
group by Department;

-- Wait time trends by month
select month(Consultation_Date) as Month, min(Wait_Time) as Minimum_Wait_Time, max(Wait_Time) as Maximum_Wait_Time
from hospital_wait_times_3
group by Month;

-- Total patients & avg wait time per department (desc)
select Department, count(*) as Total_Patients, avg(Wait_Time) as Average_Wait_Time
from hospital_wait_times_3
group by Department
order by Average_Wait_Time desc;

-- Total visits per month
select month(Arrival_Date) as Month, count(*) as Total_Visits
from hospital_wait_times_3
group by Month
order by Month;

-- Patient count per hour
select hour(Arrival_Time) as Hour, count(*) as Patient_Count
from hospital_wait_times_3
group by Hour
order by Hour;

-- Wait time stats by gender
select Gender, avg(Wait_Time) as Average_Wait_Time, min(Wait_Time) as Minimum_Wait_Time, max(Wait_Time) as Maximum_Wait_Time
from hospital_wait_times_3
group by Gender
order by Average_Wait_Time desc;

-- Total patients & avg wait time by age group
select case
         when Age < 18 then 'Under 18'
         when Age between 18 and 35 then '18-35'
         when Age between 36 and 55 then '36-55'
         when Age > 55 then '55+'
         else 'Unknown'
       end as Age_Group,
       count(*) as Total_Patients,
       avg(Wait_Time) as Average_Wait_Time
from hospital_wait_times_3
group by Age_Group
order by Average_Wait_Time desc;

