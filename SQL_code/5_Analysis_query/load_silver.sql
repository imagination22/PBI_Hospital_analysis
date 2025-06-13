/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
insert into silver.Patient
(
patient_id
,name
,age
,gender
,weight
,blood_group
,address
,STATE
,phone
,email
,admission_date
,discharge_date
,admission_status
,image_path
)
select
trim(patient_id)	as patient_id
,trim(upper(name))
,age,
CASE 
				WHEN UPPER(TRIM(gender)) = 'F' THEN 'female'
				WHEN UPPER(TRIM(gender)) = 'M' THEN 'male'
				WHEN UPPER(TRIM(gender)) = 'Female' THEN 'female'
				WHEN UPPER(TRIM(gender)) = 'Male' THEN 'male'
				ELSE 'n/a'
			END AS gender,
 weight
,blood_group
,trim(lower(address))
,trim(lower(STATE)) as STATE
,phone
,trim(lower(email)) as email
,CASE 
				WHEN  LEN(trim(admission_date)) != 10 and LEN(trim(admission_date)) != 9 and LEN(trim(admission_date)) != 9
				THEN NULL
				ELSE CAST(admission_date AS DATE)
			END AS admission_date
,CASE 
				WHEN  LEN(trim(discharge_date)) != 10 and LEN(trim(discharge_date)) != 9 and LEN(trim(discharge_date)) != 8 THEN NULL
				ELSE CAST(discharge_date  AS DATE)
			END AS discharge_date

,trim(lower(admission_status)) as admission_status
,tRIM(image_path)
 from Bronze.Patient

 /*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

ALTER TABLE Silver.Department NOCHECK CONSTRAINT ALL;

-- insert into SILVER.Department
INSERT INTO SILVER.Department (
department_id
,name
,floor
,head_doctor_id
,total_staff
,phone_extension)
 	Select 
	department_id
,name
,floor
,head_doctor_id
,total_staff
,phone_extension
	from    Bronze.Department
	where head_doctor_id  in (Select doctor_id from    Bronze.Doctor)
-- insert into SILVER_error.Department becuase head doctor doensot exists
-- logically we can have a department without doctor at first , hence we are loading into error table ,
-- error table doenst have PK , hence we can inser duplicates 
-- if we feel it needs to process , then we can talk with stakehilder , update correct doctorid and process.

INSERT INTO silver_error.Department (
department_id
,name
,floor
,head_doctor_id
,total_staff
,phone_extension)
 	Select 
	department_id
,name
,floor
,head_doctor_id
,total_staff
,phone_extension
	from    Bronze.Department
	where head_doctor_id not in (Select doctor_id from    Bronze.Doctor)


	
ALTER TABLE Silver.Department CHECK CONSTRAINT ALL;
 /*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

ALTER TABLE Silver.Doctor NOCHECK CONSTRAINT ALL;

INSERT INTO SILVER.Doctor(
doctor_id
,name
,specialization
,department_name
,salary
,STATUS
,availability
,joining_date
,qualification
,experience_years
,phone
,email
,image_path
)
  Select 
tRIM(doctor_id) AS doctor_name
,tRIM(name) AS NAME
,tRIM(specialization)
,tRIM(department_name)
,salary
,tRIM(STATUS)
,tRIM(availability)
,CASE 
				WHEN  LEN(joining_date) != 10 THEN NULL
				ELSE CAST(joining_date AS DATE)
			END AS joining_date

,qualification
,experience_years
,phone
,tRIM(email)
,tRIM(image_path) FROM Bronze.Doctor
where department_name  in (select name from bronze.Department)


INSERT INTO silver_error.Doctor(
doctor_id
,name
,specialization
,department_name
,salary
,STATUS
,availability
,joining_date
,qualification
,experience_years
,phone
,email
,image_path
)
  Select 
tRIM(doctor_id) AS doctor_id
,tRIM(name) AS NAME
,tRIM(specialization)
,tRIM(department_name)
,salary
,tRIM(STATUS)
,tRIM(availability)
,CASE 
				WHEN  LEN(joining_date) != 10 THEN NULL
				ELSE CAST(joining_date AS DATE)
			END AS joining_date

,qualification
,experience_years
,phone
,tRIM(email)
,tRIM(image_path) FROM Bronze.Doctor
where department_name  not in (select name from bronze.Department)


ALTER TABLE Silver.Doctor CHECK CONSTRAINT ALL;


/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
  insert into  silver.Appointment
  (
  appointment_id
,patient_id
,doctor_id
,appointment_date
,appointment_time
,STATUS
,reason
,doctor_notes
,suggestions
,fees
,payment_method
,discount
,diagnosis
  )
  select 
 trim(upper(appointment_id))
,trim(upper(patient_id))
,trim(upper(doctor_id))
,CASE 
				WHEN  LEN(appointment_date) != 10 THEN NULL
				ELSE CAST(appointment_date AS DATE)
			END AS appointment_date
,CASE 
				WHEN  LEN(appointment_time) != 8 THEN NULL
				ELSE CAST(appointment_time AS time)
			END AS appointment_time

,trim(lower(STATUS))
,trim(reason)
,trim(doctor_notes)
,trim(suggestions)
,fees
,trim(lower(payment_method))
,discount
,  CASE 
    WHEN diagnosis LIKE '%"%' OR diagnosis LIKE '%,%' THEN 
      trim(REPLACE(REPLACE(diagnosis, '"', ''), ',', ''))
    ELSE 
      trim(diagnosis)
  END AS diagnosis

  from Bronze.Appointment
   where doctor_id  in (select doctor_id from bronze.Doctor)
   and patient_id in (select patient_id from bronze.Patient)


    insert into  silver_error.Appointment
  (
  appointment_id
,patient_id
,doctor_id
,appointment_date
,appointment_time
,STATUS
,reason
,doctor_notes
,suggestions
,fees
,payment_method
,discount
,diagnosis
  )
    select 
 trim(upper(appointment_id))
,trim(upper(patient_id))
,trim(upper(doctor_id))
,CASE 
				WHEN  LEN(trim(appointment_date)) != 10 and LEN(trim(appointment_date)) != 9 and LEN(trim(appointment_date)) != 8  THEN NULL
				ELSE CAST(appointment_date AS DATE)
			END AS appointment_date
,CASE 
				WHEN  LEN(trim(appointment_time)) != 8 and LEN(trim(appointment_time)) != 7 THEN NULL
				ELSE CAST(appointment_time AS time)
			END AS appointment_time


,trim(lower(STATUS))
,trim(reason)
,trim(doctor_notes)
,trim(suggestions)
,fees
,trim(lower(payment_method))
,discount
,  CASE 
    WHEN diagnosis LIKE '%"%' OR diagnosis LIKE '%,%' THEN 
      trim(REPLACE(REPLACE(diagnosis, '"', ''), ',', ''))
    ELSE 
      trim(diagnosis)
  END AS diagnosis

  from Bronze.Appointment
   where doctor_id  not in (select doctor_id from bronze.Doctor)
   or patient_id not  in (select patient_id from bronze.Patient)

   /*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
   Select * from bronze.Surgery
   where appointment_id = 'APP004'

   Select * from silver.Surgery
insert into silver.Surgery
(
appointment_id
,patient_id
,doctor_id
,appointment_date
,Appointment_time
,STATUS
,reason
,comments
,surgery_notes
,fees
,payment_method
,discount
)
 Select
   appointment_id
,patient_id
,doctor_id
,CASE 
				WHEN  LEN(trim(appointment_date)) != 10 and LEN(trim(appointment_date)) != 9 and LEN(trim(appointment_date)) != 8  THEN NULL
				ELSE CAST(appointment_date AS DATE)
			END AS appointment_date
,CASE 
				WHEN  LEN(trim(appointment_time)) != 8 and LEN(trim(appointment_time)) != 7 THEN NULL
				ELSE CAST(appointment_time AS time)
			END AS appointment_time

,STATUS
,reason
,comments
,surgery_notes
,fees
,payment_method
,discount
from bronze.Surgery
where appointment_id in (select distinct appointment_id from bronze.Appointment)
and doctor_id in (select distinct doctor_id from bronze.Doctor)
and patient_id in (select distinct patient_id from bronze.Patient)


   Select * from silver_error.Surgery

insert into silver_error.Surgery
(
appointment_id
,patient_id
,doctor_id
,appointment_date
,Appointment_time
,STATUS
,reason
,comments
,surgery_notes
,fees
,payment_method
,discount
)
 Select
   appointment_id
,patient_id
,doctor_id
,CASE 
				WHEN  LEN(trim(appointment_date)) != 10 and LEN(trim(appointment_date)) != 9 and LEN(trim(appointment_date)) != 8  THEN NULL
				ELSE CAST(appointment_date AS DATE)
			END AS appointment_date
,CASE 
				WHEN  LEN(trim(appointment_time)) != 8 and LEN(trim(appointment_time)) != 7 THEN NULL
				ELSE CAST(appointment_time AS time)
			END AS appointment_time

,STATUS
,reason
,comments
,surgery_notes
,fees
,payment_method
,discount
from bronze.Surgery
where appointment_id not in (select distinct appointment_id from bronze.Appointment)
or doctor_id not in (select distinct doctor_id from bronze.Doctor)
or patient_id not in (select distinct patient_id from bronze.Patient)

   /*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

   Select * from bronze.room
   select * from Silver.room
   Select * from silver.Department
   insert into Silver.room
   (
   room_id
,department_id
,room_type
,floor
,capacity
,STATUS
,daily_charges
,avg_monthly_maintenance
   )
   Select 
room_id
,department_id
,room_type
,floor
,capacity
,STATUS
,daily_charges
,avg_monthly_maintenance
   
   from bronze.room
   where department_id in (select department_id from silver.Department)


   insert into Silver_error.room
   (
   room_id
,department_id
,room_type
,floor
,capacity
,STATUS
,daily_charges
,avg_monthly_maintenance
   )
   Select 
room_id
,department_id
,room_type
,floor
,capacity
,STATUS
,daily_charges
,avg_monthly_maintenance
   from bronze.room
   where department_id not  in (select department_id from silver.Department)

      /*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

	  Select * from bronze.Bed
	  select * from silver.bed


	  insert into silver.bed(
	  bed_id
,room_id
,current_status
,patient_id
,occupation_start_time
,occupation_end_time
	  )
	  select 
	  bed_id
,room_id
,current_status
, case when patient_id ='null' then NULL
		else patient_id end  as patient_id
,case when 
	occupation_start_time ='null' then NULL
		WHEN  LEN(trim(occupation_start_time)) != 10 and LEN(trim(occupation_start_time)) != 8 and LEN(trim(occupation_start_time)) != 9 THEN NULL
				ELSE CAST(occupation_start_time AS date)
	end as occupation_start_time
,case when 
	occupation_end_time ='null' then NULL
		WHEN  LEN(trim(occupation_end_time)) != 10 and LEN(trim(occupation_end_time)) != 8 and LEN(trim(occupation_end_time)) != 9 THEN NULL
				ELSE CAST(occupation_end_time AS date)
	end as occupation_end_time
from bronze.Bed
	where room_id in (select distinct room_id from silver.Room)  


	insert into silver_error.bed(
	  bed_id
,room_id
,current_status
,patient_id
,occupation_start_time
,occupation_end_time
	  )
		  select 
	  bed_id
,room_id
,current_status
, case when patient_id ='null' then NULL
		else patient_id end  as patient_id
,case when 
	occupation_start_time ='null' then NULL
		WHEN  LEN(trim(occupation_start_time)) != 10 and LEN(trim(occupation_start_time)) != 8 and LEN(trim(occupation_start_time)) != 9 THEN NULL
				ELSE CAST(occupation_start_time AS date)
	end as occupation_start_time
,case when 
	occupation_end_time ='null' then NULL
		WHEN  LEN(trim(occupation_end_time)) != 10 and LEN(trim(occupation_end_time)) != 8 and LEN(trim(occupation_end_time)) != 9 THEN NULL
				ELSE CAST(occupation_end_time AS date)
	end as occupation_end_time
from bronze.Bed
	where room_id not  in (select distinct room_id from silver.Room) 

	  /*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
	  Select * from bronze.Billing
	  select * from silver.Billing

	  insert into silver.Billing(
	  bill_id
,patient_id
,admission_date
,discharge_date
,room_charges
,surgery_charges
,medicine_charges
,test_charges
,doctor_fees
,other_charges
,total_amount
,discount
,amount_paid
,payment_status
,payment_method
	  )
	  select bill_id
,patient_id
,case when 
	admission_date ='null' then NULL
		WHEN  LEN(trim(admission_date)) != 10 and LEN(trim(admission_date)) != 8 and LEN(trim(admission_date)) != 9 THEN NULL
				ELSE CAST(admission_date AS date) end as admission_date

,case when 
	discharge_date ='null' then NULL
		WHEN  LEN(trim(discharge_date)) != 10 and LEN(trim(discharge_date)) != 8 and LEN(trim(discharge_date)) != 9 THEN NULL
				ELSE CAST(discharge_date AS date) end as discharge_date


,room_charges
,surgery_charges
,medicine_charges
,test_charges
,doctor_fees
,other_charges
,total_amount
,discount
,amount_paid
,payment_status
,payment_method
from bronze.Billing
where patient_id in (select distinct patient_id from silver.Patient)




	   insert into silver.Billing(
	  bill_id
,patient_id
,admission_date
,discharge_date
,room_charges
,surgery_charges
,medicine_charges
,test_charges
,doctor_fees
,other_charges
,total_amount
,discount
,amount_paid
,payment_status
,payment_method
	  )
	  select bill_id
,patient_id
,case when 
	admission_date ='null' then NULL
		WHEN  LEN(trim(admission_date)) != 10 and LEN(trim(admission_date)) != 8 and LEN(trim(admission_date)) != 9 THEN NULL
				ELSE CAST(admission_date AS date) end as admission_date

,case when 
	discharge_date ='null' then NULL
		WHEN  LEN(trim(discharge_date)) != 10 and LEN(trim(discharge_date)) != 8 and LEN(trim(discharge_date)) != 9 THEN NULL
				ELSE CAST(discharge_date AS date) end as discharge_date


,room_charges
,surgery_charges
,medicine_charges
,test_charges
,doctor_fees
,other_charges
,total_amount
,discount
,amount_paid
,payment_status
,payment_method
from bronze.Billing
where patient_id not in (select distinct patient_id from silver.Patient)

 /*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/