--	Silver layer DDL  Bronze.
	-- Address Table


	--  Patient Table
	CREATE TABLE Bronze.Patient (
		patient_id VARCHAR(255) ,
		name VARCHAR(255),
		age INT,
		gender VARCHAR(10),
		weight DECIMAL(5,2),
		blood_group VARCHAR(10),
		address varchar(max),
		state varchar(255),
		phone VARCHAR(20),
		email VARCHAR(255),
		
		admission_date VARCHAR(12),
		discharge_date VARCHAR(12),
		admission_status VARCHAR(50),
		
		image_path VARCHAR(500) default Null ,
		
	);
	--  Department Table
	CREATE TABLE Bronze.Department (
		department_id VARCHAR(255) ,
		name VARCHAR(255),
		floor INT,
		head_doctor_id VARCHAR(255),
		total_staff INT,
		phone_extension VARCHAR(10),
		
	);

	--  Doctor Table
	CREATE TABLE Bronze.Doctor (
		doctor_id VARCHAR(255) ,
		name VARCHAR(255),
		specialization VARCHAR(100),
		department_id VARCHAR(255),
		salary DECIMAL(10,2),
		status VARCHAR(50),
		availability VARCHAR(50),
		joining_date VARCHAR(12),
		qualification VARCHAR(255),
		experience_years INT,
		phone VARCHAR(20),
		email VARCHAR(255),
		image_path VARCHAR(500),
		
	);



	--  Appointment Table
	CREATE TABLE Bronze.Appointment (
		appointment_id VARCHAR(255),
		patient_id VARCHAR(255),
		doctor_id VARCHAR(255),
		appointment_date VARCHAR(12),
		appointment_time TIME,
		status varchar(max),
		reason varchar(max),
		doctor_notes varchar(max),	
		suggestions varchar(max),
		fees DECIMAL(10,2),
		payment_method VARCHAR(50),
		discount DECIMAL(5,2),
		diagnosis varchar(max),
	);

	--  Surgery Table
	CREATE TABLE Bronze.Surgery (
		--surgery_id VARCHAR(255) ,
		appointment_id VARCHAR(255),
		patient_id VARCHAR(255),
		doctor_id VARCHAR(255),
		appointment_date VARCHAR(12), 
		Appointment_time VARCHAR(20),
		status VARCHAR(50),
		reason VARCHAR(255),
		comments VARCHAR(255),
		surgery_notes varchar(max),
		fees DECIMAL(10,2),
		payment_method VARCHAR(50),
		discount DECIMAL(5,2),
		
	);

	--  Room Table
	CREATE TABLE Bronze.Room (
		room_id VARCHAR(255) ,
		department_id VARCHAR(255),
		room_type VARCHAR(50),
		floor INT,
		capacity INT,
		status VARCHAR(50),
		daily_charges DECIMAL(10,2),
		avg_monthly_maintenance DECIMAL(10,2),
		
	);

	--  Bed Table
	CREATE TABLE Bronze.Bed (
		bed_id VARCHAR(255) ,
		room_id VARCHAR(255),
		current_status VARCHAR(50),
		patient_id VARCHAR(255) NULL,
		occupation_start_time VARCHAR(255) ,
		occupation_end_time VARCHAR(255) ,
		
		
	);

	--  Billing Table
	--drop table  Bronze.Billing
	CREATE TABLE Bronze.Billing (
		bill_id VARCHAR(255) ,
		patient_id VARCHAR(255),
		admission_date VARCHAR(12),
		discharge_date VARCHAR(12),
		room_charges DECIMAL(10,2),
		surgery_charges DECIMAL(10,2),
		medicine_charges DECIMAL(10,2),
		test_charges DECIMAL(10,2),
		doctor_fees DECIMAL(10,2),
		other_charges DECIMAL(10,2),
		total_amount DECIMAL(10,2),
		discount DECIMAL(10,2),
		amount_paid DECIMAL(10,2),
		payment_status VARCHAR(50),
		payment_method VARCHAR(50),
		
	);

	--  Medical Stock Table
	
	CREATE TABLE Bronze.MedicalStock (
		medicine_id VARCHAR(255) ,
		name VARCHAR(255),
		category VARCHAR(100),
		supplier_id VARCHAR(255),
		cost_price DECIMAL(10,2),
		unit_price DECIMAL(10,2),
		stock_quantity INT,
		expiry_date VARCHAR(12),
		manufacturing_date VARCHAR(12),
		batch_number VARCHAR(50),
		reorder_level INT,
		
	);
	
	--  Medical Test Table
	CREATE TABLE Bronze.MedicalTest (
		test_id VARCHAR(255),
		test_name VARCHAR(255),
		category VARCHAR(100),
		department_id VARCHAR(255),
		cost DECIMAL(10,2),
		duration INT,
		fasting_required VARCHAR(10),

	);

	--  Patient Test Table
	CREATE TABLE Bronze.PatientTest (
		patient_test_id varchar(255),
		patient_id VARCHAR(255),
		test_id VARCHAR(255),
		doctor_id VARCHAR(255),
		test_date VARCHAR(12),
		result_date VARCHAR(12),
		status VARCHAR(255),
		result VARCHAR(255),
		result_notes varchar(max),
		amount DECIMAL(10,2),
		payment_method VARCHAR(50),

		
		discount DECIMAL(5,2),
		
	);

	--  Satisfaction Score Table
	CREATE TABLE Bronze.SatisfactionScore (
		satisfaction_id varchar(255),
		patient_id VARCHAR(255),
		doctor_id varchar(255),
		rating INT,
		feedback varchar(max),
		date VARCHAR(12),
		department_id varchar(255),
		
	);

	--  Staff Table
	CREATE TABLE Bronze.Staff (
		staff_id VARCHAR(255) ,
		name VARCHAR(255),
		department_id VARCHAR(255),
		role VARCHAR(100),
		salary DECIMAL(10,2),
		joining_date VARCHAR(12),
		shift VARCHAR(50),
		phone VARCHAR(20),
		email VARCHAR(255),
		address varchar(max),
	
	);

	--  Supplier Table
	CREATE TABLE Bronze.Supplier (
		supplier_id VARCHAR(255),
		name VARCHAR(255),
		contact_person VARCHAR(255),
		phone VARCHAR(20),
		email VARCHAR(255),
		address varchar(max),
		city varchar(max),
		landmark VARCHAR(255),
		pincode int  , 
		state VARCHAR(255),
		contract_start VARCHAR(255),
		contract_end VARCHAR(255)
	);

	-- medicine_patient missin
CREATE TABLE Bronze.medicine_patient (
		patient_id VARCHAR(255) ,
		medicine VARCHAR(255),
		Quantity INT,
		purchase_date VARCHAR(12),
	
	);
