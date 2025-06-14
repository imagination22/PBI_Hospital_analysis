	 
	 -- create Sb and schema
	exec bronze.create_ddl_bronze
	exec Silver.create_ddl_silver
	exec Silver_error.create_ddl_error_silver
	exec Gold.create_ddl_gold
	EXEC bronze.load_bronze;
	EXEC silver.load_silver;

	Select count(*) from 	Bronze.Patient
	Select count(*) from    Bronze.Department
	Select count(*) from    Bronze.Doctor
	Select count(*) from    Bronze.Appointment
	Select count(*) from    Bronze.Surgery
	Select count(*) from    Bronze.Room
	Select count(*) from    Bronze.Bed 
	Select count(*) from    Bronze.Billing
	Select count(*) from    Bronze.MedicalStock
	Select count(*) from    Bronze.MedicalTest
	Select count(*) from    Bronze.PatientTest
	Select count(*) from    Bronze.SatisfactionScore
	Select count(*) from    Bronze.Staff
	Select count(*) from    Bronze.Supplier
	Select count(*) from    Bronze.medicine_patient


select count(*) from  Silver_error.Appointment
select count(*) from  Silver_error.Bed
select count(*) from  Silver_error.Billing
select count(*) from  Silver_error.Department
select count(*) from  Silver_error.Doctor
select count(*) from  Silver_error.MedicalStock
select count(*) from  Silver_error.MedicalTest
select count(*) from  Silver_error.medicine_patient
select count(*) from  Silver_error.Patient
select count(*) from  Silver_error.PatientTest
select count(*) from  Silver_error.Room
select count(*) from  Silver_error.SatisfactionScore
select count(*) from  Silver_error.Staff
select count(*) from  Silver_error.Supplier
select count(*) from  Silver_error.Surgery


select count(*) from  Silver.Appointment
select count(*) from  Silver.Bed
select count(*) from  Silver.Billing
select count(*) from  Silver.Department
select count(*) from  Silver.Doctor
select count(*) from  Silver.MedicalStock
select count(*) from  Silver.MedicalTest
select count(*) from  Silver.medicine_patient
select count(*) from  Silver.Patient
select count(*) from  Silver.PatientTest
select count(*) from  Silver.Room
select count(*) from  Silver.SatisfactionScore
select count(*) from  Silver.Staff
select count(*) from  Silver.Supplier
select count(*) from  Silver.Surgery


select count(*) from Gold.Agg_BedOccupancy
select count(*) from Gold.Agg_DoctorPerformance
select count(*) from Gold.Agg_MonthlyRevenue
select count(*) from Gold.Dim_Bed
select count(*) from Gold.Dim_Date
select count(*) from Gold.Dim_Department
select count(*) from Gold.Dim_Doctor
select count(*) from Gold.Dim_Medicine
select count(*) from Gold.Dim_Patient
select count(*) from Gold.Dim_PaymentMethod
select count(*) from Gold.Dim_Room
select count(*) from Gold.Dim_Supplier
select count(*) from Gold.Dim_Test
select count(*) from Gold.Fact_Appointments
select count(*) from Gold.Fact_Billing
select count(*) from Gold.Fact_MedicinePurchases
select count(*) from Gold.Fact_PatientStay
select count(*) from Gold.Fact_Tests


	Select * from 	Bronze.Patient
	Select * from    Bronze.Department
	Select * from    Bronze.Doctor
	Select * from    Bronze.Appointment
	Select * from    Bronze.Surgery
	Select * from    Bronze.Room
	Select * from    Bronze.Bed 
	Select * from    Bronze.Billing
	Select * from    Bronze.MedicalStock
	Select * from    Bronze.MedicalTest
	Select * from    Bronze.PatientTest
	Select * from    Bronze.SatisfactionScore
	Select * from    Bronze.Staff
	Select * from    Bronze.Supplier
	Select * from    Bronze.medicine_patient

	Select * from 	Silver.Patient
	Select * from    Silver.Department
	Select * from    Silver.Doctor
	Select * from    Silver.Appointment
	Select * from    Silver.Surgery
	Select * from    Silver.Room
	Select * from    Silver.Bed 
	Select * from    Silver.Billing
	Select * from    Silver.MedicalStock
	Select * from    Silver.MedicalTest
	Select * from    Silver.PatientTest
	Select * from    Silver.SatisfactionScore
	Select * from    Silver.Staff
	Select * from    Silver.Supplier
	Select * from    Silver.medicine_patient
	
