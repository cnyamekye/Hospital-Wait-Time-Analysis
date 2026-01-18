-- ============================
-- 1. REMOVING DUPLICATES
-- ============================

-- Creating a working copy of the dataset
create table hospital_wait_times_3 
like hospital_wait_times;

-- Inserting the original data into the new table
insert into hospital_wait_times_3
select *
from hospital_wait_times;

-- Adding an auto-increment ID to help identify duplicate rows
alter table hospital_wait_times_3
add id int auto_increment primary key;

-- Checking duplicate patterns using key identifiers
select *,
row_number() over (
    partition by Patient_ID, Arrival_Date, Arrival_Time, Doctor_ID
) as Row_Num
from hospital_wait_times_3;

-- Returning only rows flagged as duplicates
with duplicate_cte as (
    select *,
    row_number() over (
        partition by Patient_ID, Arrival_Date, Arrival_Time, Doctor_ID
    ) as Row_Num
    from hospital_wait_times_3
)
select *
from duplicate_cte
where Row_Num > 1;

-- Deleting the extra duplicate rows (keeping only the first occurrence)
with duplicate_cte as (
    select *,
    row_number() over (
        partition by Patient_ID, Arrival_Date, Arrival_Time, Doctor_ID
    ) as Row_Num
    from hospital_wait_times_3
)
delete 
from hospital_wait_times_3
where id in (
    select id
    from duplicate_cte 
    where row_num > 1
);

-- Removing the temporary ID column after cleanup
alter table hospital_wait_times_3
drop id;



-- ============================
-- 2. STANDARDIZING THE DATA
-- ============================

-- Removing leading/trailing spaces from text fields
update hospital_wait_times_3
set 
  Gender = trim(Gender),
  Department = trim(Department),
  Appointment_Type = trim(Appointment_Type),
  Visit_Status = trim(Visit_Status),
  Visit_Day = trim(Visit_Day),
  Notes = trim(Notes),
  Temp_Field= trim(Temp_Field);

-- Inspecting unique Patient_ID values
select distinct Patient_ID
from hospital_wait_times_3
order by 1 asc;

-- Checking distinct age values
select distinct Age
from hospital_wait_times_3
order by 1 desc;

-- Replacing invalid age values (0 or negative) with NULL
update hospital_wait_times_3
set Age = Null 
where Age <= 0;

-- Ensuring Age is stored as an integer
alter table hospital_wait_times_3
modify Age int;

-- Reviewing unique gender values
select distinct Gender
from hospital_wait_times_3
order by Gender asc;

-- Standardizing gender values
update hospital_wait_times_3
set Gender = 'Female'
where Gender in ('Fem','FEMALE','Fmale','f');

update hospital_wait_times_3
set Gender = 'Male'
where Gender in ('M','MALE');


-- Checking department variations
select distinct Department
from hospital_wait_times_3
order by Department asc;

-- Standardizing department names
update hospital_wait_times_3
set Department = 'General Surgery'
where Department in  ('G Surgery','Gen Surgery');

update hospital_wait_times_3
set Department = 'ENT'
where Department = 'ent';

update hospital_wait_times_3
set Department = 'Cardiology'
where Department = 'Cardio logy';

update hospital_wait_times_3
set Department = 'Dermatology'
where Department = 'derma tology';

update hospital_wait_times_3
set Department = 'Pediatrics'
where Department = 'Pedtrics';

update hospital_wait_times_3
set Department = 'Neurology'
where Department = 'Neuro Logy';

update hospital_wait_times_3
set Department = 'Orthopedics'
where Department = 'ORTHO';

-- Rechecking cleaned department list
select distinct Department
from hospital_wait_times_3
order by Department asc;


-- -----------------------------
-- Cleaning and formatting dates
-- -----------------------------

select distinct Arrival_Date
from hospital_wait_times_3
order by 1 asc;

-- Converting Arrival_Date into a uniform date format
update hospital_wait_times_3
set Arrival_Date = 
    case
        when Arrival_Date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' then 
            str_to_date(Arrival_Date, '%m/%d/%Y')
        when Arrival_Date regexp '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$' then 
            str_to_date(Arrival_Date, '%M %d, %Y')
        when Arrival_Date regexp '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$' then
            str_to_date(Arrival_Date, '%d-%m-%Y')
        else Arrival_Date  
	end;

-- Converting column to a DATE datatype
alter table hospital_wait_times_3
modify column Arrival_Date date;


-- Appointment_Date cleaning
select distinct Appointment_Date
from hospital_wait_times_3
order by 1 asc; 

update hospital_wait_times_3
set  Appointment_Date = 
    case
        when Appointment_Date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' then 
            str_to_date(Appointment_Date, '%m/%d/%Y')
        when Appointment_Date regexp '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$' then
            str_to_date(Appointment_Date, '%d-%m-%Y')
        when Appointment_Date regexp '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$' then 
            str_to_date(Appointment_Date, '%M %d, %Y')
        else Appointment_Date 
    end;

alter table hospital_wait_times_3
modify column Appointment_Date date;


-- Consultation_Date cleaning
select distinct Consultation_Date
from hospital_wait_times_3
order by 1 asc; 

update hospital_wait_times_3
set  Consultation_Date = 
    case
        when Consultation_Date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' then 
            str_to_date(Consultation_Date, '%m/%d/%Y')
        when Consultation_Date regexp '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$' then
            str_to_date(Consultation_Date, '%d-%m-%Y')
        when Consultation_Date regexp '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$' then 
            str_to_date(Consultation_Date, '%M %d, %Y')
        else Consultation_Date
    end;

alter table hospital_wait_times_3
modify column Consultation_Date date;


-- -----------------------------
-- Standardizing time columns
-- -----------------------------

select distinct Arrival_Time 
from hospital_wait_times_3
order by 1 desc;

alter table hospital_wait_times_3
modify Arrival_Time datetime;

select distinct Appointment_Time 
from hospital_wait_times_3
order by 1 desc;

alter table hospital_wait_times_3
modify Appointment_Time datetime;

select distinct Consultation_Start
from hospital_wait_times_3
order by 1 desc;

alter table hospital_wait_times_3
modify Consultation_Start datetime;


-- Cleaning Wait_Time values
select distinct Wait_Time
from hospital_wait_times_3
order by 1 desc;

update hospital_wait_times_3
set Wait_Time = Null
where Wait_Time <= 0;


-- -----------------------------
-- Cleaning categorical fields
-- -----------------------------

select distinct Doctor_ID
from hospital_wait_times_3
order by 1 desc;

select distinct Appointment_Type
from hospital_wait_times_3
order by 1 desc;

update hospital_wait_times_3
set Appointment_Type = 'Routine'
where Appointment_Type in ('ROUTINE','Routin');

update hospital_wait_times_3
set Appointment_Type = 'Emergency'
where Appointment_Type in ('emergncy','Emergency','Emerg');


select distinct Visit_Status
from hospital_wait_times_3
order by 1 desc;

update hospital_wait_times_3
set Visit_Status = 'Pending'
where Visit_Status = 'pendng';

update hospital_wait_times_3
set Visit_Status = 'No show'
where Visit_Status in ('no-show','NO SHOW');

update hospital_wait_times_3
set Visit_Status = 'Completed'
where Visit_Status in ('completed','Complet');

update hospital_wait_times_3
set Visit_Status = 'Cancelled'
where Visit_Status = 'CANCELED';


-- Notes field cleaning
select distinct Visit_Day
from hospital_wait_times_3
order by Visit_Day desc;

select distinct Notes
from hospital_wait_times_3
order by Notes desc;

update hospital_wait_times_3
set Notes = Null
where Notes = 'N/A';


-- Temp_Field harmonization
select distinct Temp_Field
from hospital_wait_times_3
order by Temp_Field desc;

update hospital_wait_times_3
set Temp_Field = 'Temp'
where Temp_Field = 'temp';

update hospital_wait_times_3
set Temp_Field = 'Remove'
where Temp_Field = 'remove';



-- ============================
-- 3. HANDLING NULLS OR BLANKS
-- ============================

-- Checking missing values column by column
select *
from hospital_wait_times_3
where Patient_ID is null or Patient_ID = "";

select *
from hospital_wait_times_3
where Age is null or Age = "";

select *
from hospital_wait_times_3
where Gender is null or Gender = "";

select *
from hospital_wait_times_3
where Department is null or Department = "";

select *
from hospital_wait_times_3
where Wait_Time is null or Wait_Time = "";

select *
from hospital_wait_times_3
where Doctor_ID is null or Doctor_ID = "";

-- Converting blank Doctor_ID to NULL
update hospital_wait_times_3
set Doctor_ID = Null
where Doctor_ID = "";

select *
from hospital_wait_times_3
where Appointment_Type is null or Appointment_Type = "";

select *
from hospital_wait_times_3
where Visit_Status is null or Visit_Status = "";

select *
from hospital_wait_times_3
where Visit_Day is null or Visit_Day = "";

select *
from hospital_wait_times_3
where Notes is null or Notes = "";

-- Setting blank notes to NULL
update hospital_wait_times_3
set Notes = "Missing"
where Notes = "";

select *
from hospital_wait_times_3
where Temp_Field is null or Temp_Field = "";

-- Checking missing date/time fields
select *
from hospital_wait_times_3
where Arrival_Date is null;

select *
from hospital_wait_times_3
where Appointment_Date is null;

select *
from hospital_wait_times_3
where Arrival_Time is null;

select *
from hospital_wait_times_3
where Appointment_Time is null;

select *
from hospital_wait_times_3
where Consultation_Start is null;

-- Cleaning blank Temp_Field entries
update hospital_wait_times_3
set Temp_Field = "Missing"
where Temp_Field = "";

-- Final preview of the cleaned dataset
select *
from hospital_wait_times_3;



