
/******************************************************************************************************/
--if not  exists(
--select 1 from Gold.DIM_date
--)
--begin
--WITH DateSeries AS (
--    SELECT CAST('2000-01-01' AS DATE) AS date
--    UNION ALL
--    SELECT DATEADD(DAY, 1, date)
--    FROM DateSeries
--    WHERE date < '2050-12-31'
--)
--INSERT INTO GOLD.Dim_Date (date_key, date, day, month, year, quarter, weekday_name, is_weekend)
--SELECT
--    CONVERT(INT, FORMAT(date, 'yyyyMMdd')) AS date_key,
--    date,
--    DAY(date) AS day,
--    MONTH(date) AS month,
--    YEAR(date) AS year,
--    DATEPART(QUARTER, date) AS quarter,
--    DATENAME(WEEKDAY, date) AS weekday_name,
--    CASE WHEN DATEPART(WEEKDAY, date) IN (1, 7) THEN 1 ELSE 0 END AS is_weekend
--FROM DateSeries
--OPTION (MAXRECURSION 0);
--end 

--select * from Gold.DIM_date


/******************************************************************************************************/


INSERT INTO GOLD.Dim_Patient (
  
    patient_id,
    name,
    gender,
    age,
    blood_group,
    state,
    admission_status,
    image_path
)
SELECT
   
    patient_id,
    name,
    gender,
    age,
    blood_group,
    CAST(state AS VARCHAR(50)),
    admission_status,
    image_path
FROM Silver.Patient;




INSERT INTO GOLD.Dim_Doctor (
  
    doctor_id,
    name,
    specialization,
    experience_years,
    availability
)
SELECT
   -- ROW_NUMBER() OVER (ORDER BY doctor_id) AS doctor_key,
    doctor_id,
    name,
    specialization,
    experience_years,
    availability
FROM Silver.Doctor;


/*
INSERT INTO GOLD.Dim_Department (
    --department_key,
    department_id,
    name,
    total_staff
)
SELECT
   
    department_id,
    name,
    total_staff
FROM Silver.Department;*/
INSERT INTO GOLD.Dim_Department (department_id, name, floor, head_doctor_id, total_staff, phone_extension)
SELECT DISTINCT
    department_id, name, floor, head_doctor_id, total_staff, phone_extension
FROM Silver.Department;

select * from GOLD.Dim_PaymentMethod

INSERT INTO GOLD.Dim_PaymentMethod ( method_name)
SELECT
    DISTINCT payment_method
FROM Silver.Appointment
WHERE payment_method IS NOT NULL;


INSERT INTO GOLD.Fact_PatientVitals (
    patient_skey,
    record_date,
    weight
)
SELECT
    dp.patient_skey,
    GETDATE(), -- assuming latest vitals on load
    sp.weight
FROM Silver.Patient sp
JOIN GOLD.Dim_Patient dp ON sp.patient_id = dp.patient_id
WHERE sp.weight IS NOT NULL;

INSERT INTO GOLD.Fact_Admissions (
    patient_skey,
    admission_date,
    discharge_date,
    admission_status
)
SELECT
    dp.patient_skey,
    sp.admission_date,
    sp.discharge_date,
    sp.admission_status
FROM Silver.Patient sp
JOIN GOLD.Dim_Patient dp ON sp.patient_id = dp.patient_id
WHERE sp.admission_date IS NOT NULL;


INSERT INTO GOLD.Fact_Appointments (
    appointment_id,
    patient_skey,
    doctor_skey,
    department_skey,
    date_skey,
    reason,
    diagnosis,
    payment_method_skey,
    discount,
    fees
)
SELECT
    sa.appointment_id,
    dp.patient_skey,
    dd.doctor_skey,
    dpt.department_skey,
    ddim.date_skey,
    sa.reason,
    sa.diagnosis,
    pm.payment_method_skey,
    sa.discount,
    sa.fees
FROM Silver.Appointment sa
JOIN GOLD.Dim_Patient dp
    ON sa.patient_id = dp.patient_id
JOIN GOLD.Dim_Doctor dd
    ON sa.doctor_id = dd.doctor_id
JOIN Silver.Doctor sd
    ON sa.doctor_id = sd.doctor_id
JOIN GOLD.Dim_Department dpt
    ON sd.department_name = dpt.name
JOIN GOLD.Dim_PaymentMethod pm
    ON sa.payment_method = pm.method_name
JOIN GOLD.Dim_Date ddim
    ON sa.appointment_date = ddim.full_date;  -- Adjust if your Dim_Date uses another column name


INSERT INTO GOLD.Dim_Room (room_id, room_type, floor, capacity, status, daily_charges, avg_monthly_maintenance)
SELECT DISTINCT
    room_id, room_type, floor, capacity, status, daily_charges, avg_monthly_maintenance
FROM Silver.Room;

INSERT INTO GOLD.Dim_Bed (bed_id, room_skey, status, occupation_start_time, occupation_end_time)
SELECT 
    b.bed_id, r.room_skey, b.current_status, b.occupation_start_time, b.occupation_end_time
FROM Silver.Bed b
JOIN GOLD.Dim_Room r ON b.room_id = r.room_id;
