-- Creating a working copy of the dataset
create table hospital_wait_times_3 
like hospital_wait_times;

-- Inserting the original data into the new table
insert into hospital_wait_times_3
select *
from hospital_wait_times;
