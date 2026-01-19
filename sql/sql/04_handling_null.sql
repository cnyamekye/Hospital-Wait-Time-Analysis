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
