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
