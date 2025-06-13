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
				WHEN  LEN(admission_date) != 10 THEN NULL
				ELSE CAST(admission_date AS DATE)
			END AS admission_date
,CASE 
				WHEN  LEN(discharge_date) != 10 THEN NULL
				ELSE CAST(discharge_date  AS DATE)
			END AS discharge_date

,trim(lower(admission_status)) as admission_status
,tRIM(image_path)
 from Bronze.Patient


 ALTER TABLE Silver.Department NOCHECK CONSTRAINT ALL;
ALTER TABLE Silver.Doctor NOCHECK CONSTRAINT ALL;

INSERT INTO SILVER.Doctor(
doctor_id
,name
,specialization
,department_id
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
,tRIM(department_id)
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

 -- FIRST DOCTOR NEEDS TO BE POPULATED.
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

	ALTER TABLE Silver.Department CHECK CONSTRAINT ALL;
ALTER TABLE Silver.Doctor CHECK CONSTRAINT ALL;