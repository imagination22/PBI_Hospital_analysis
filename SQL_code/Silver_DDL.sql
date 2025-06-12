--	Silver layer DDL  Silver.
	-- Address Table
	/*
CREATE TABLE Silver.Address (
    address_id INT PRIMARY KEY IDENTITY(1,1),
    address NVARCHAR(255),
    city NVARCHAR(100) default Null ,
    state NVARCHAR(100),
    pincode NVARCHAR(20) default Null,
	FOREIGN KEY (address_id) REFERENCES Silver.Address(address_id)
)
;*/

	--  Patient Table
	CREATE TABLE Silver.Patient (
		patient_id VARCHAR(255) PRIMARY KEY,
		name VARCHAR(255),
		age INT,
		gender VARCHAR(10),
		weight DECIMAL(5,2),
		blood_group VARCHAR(10),
		address varchar(max),
		state varchar(255),
		phone VARCHAR(20),
		email VARCHAR(255),
		admission_date DATE,
		discharge_date DATE,
		admission_status VARCHAR(50),
		image_path VARCHAR(500) default Null ,	
	);
	--  Department Table
	CREATE TABLE Silver.Department (
		department_id VARCHAR(255) PRIMARY KEY,
		name VARCHAR(255),
		floor INT,
		head_doctor_id VARCHAR(255),
		total_staff INT,
		phone_extension VARCHAR(10),
		--FOREIGN KEY (head_doctor_id) REFERENCES Doctor(doctor_id)
	);

	--  Doctor Table
	CREATE TABLE Silver.Doctor (
			doctor_id VARCHAR(255) PRIMARY KEY,
		name VARCHAR(255),
		specialization VARCHAR(100),
		department_id VARCHAR(255),
		salary DECIMAL(10,2),
		status VARCHAR(50),
		availability VARCHAR(50),
		joining_date DATE,
		qualification VARCHAR(255),
		experience_years INT,
		phone VARCHAR(20),
		email VARCHAR(255),
		image_path VARCHAR(500),
		FOREIGN KEY (department_id) REFERENCES Silver.Department(department_id)
	);

	ALTER TABLE Silver.Department
ADD CONSTRAINT FK_Department_HeadDoctor
FOREIGN KEY (head_doctor_id) REFERENCES Silver.Doctor(doctor_id);

	--  Appointment Table
	CREATE TABLE Silver.Appointment (
		appointment_id VARCHAR(255) PRIMARY KEY,
		patient_id VARCHAR(255),
		doctor_id VARCHAR(255),
		appointment_date DATE,
		appointment_time TIME,
		status varchar(max),
		reason varchar(max),
		doctor_notes varchar(max),	
		suggestions varchar(max),
		fees DECIMAL(10,2),
		payment_method VARCHAR(50),
		discount DECIMAL(5,2),
		diagnosis varchar(max),
		FOREIGN KEY (patient_id) REFERENCES Silver.Patient(patient_id),
		FOREIGN KEY (doctor_id) REFERENCES Silver.Doctor(doctor_id)
	);

	--  Surgery Table
	CREATE TABLE Silver.Surgery (
		--surgery_id VARCHAR(255) PRIMARY KEY,
		appointment_id VARCHAR(255),
		patient_id VARCHAR(255),
		doctor_id VARCHAR(255),
		appointment_date Date , 
		Appointment_time datetime2 , 
		status VARCHAR(50),
		reason VARCHAR(255),
		surgery_notes varchar(max),
		fees DECIMAL(10,2),
		payment_method VARCHAR(50),
		discount DECIMAL(5,2),
		FOREIGN KEY (appointment_id) REFERENCES Silver.Appointment(appointment_id),
		FOREIGN KEY (patient_id) REFERENCES Silver.Patient(patient_id),
		FOREIGN KEY (doctor_id) REFERENCES Silver.Doctor(doctor_id)
	);

	--  Room Table
	CREATE TABLE Silver.Room (
		room_id VARCHAR(255) PRIMARY KEY,
		department_id VARCHAR(255),
		room_type VARCHAR(50),
		floor INT,
		capacity INT,
		status VARCHAR(50),
		daily_charges DECIMAL(10,2),
		avg_monthly_maintenance DECIMAL(10,2),
		FOREIGN KEY (department_id) REFERENCES Silver.Department(department_id)
	);

	--  Bed Table
	CREATE TABLE Silver.Bed (
		bed_id VARCHAR(255) PRIMARY KEY,
		room_id VARCHAR(255),
		current_status VARCHAR(50),
		patient_id VARCHAR(255) NULL,
		occupation_start_time DATETIME,
		occupation_end_time DATETIME,
		FOREIGN KEY (room_id) REFERENCES Silver.Room(room_id),
		FOREIGN KEY (patient_id) REFERENCES Silver.Patient(patient_id)
	);

	--  Billing Table
	CREATE TABLE Silver.Billing (
		bill_id VARCHAR(255) PRIMARY KEY,
		patient_id VARCHAR(255),
		admission_date DATE,
		discharge_date DATE,
		room_charges DECIMAL(10,2),
		surgery_charges DECIMAL(10,2),
		medicine_charges DECIMAL(10,2),
		test_charges DECIMAL(10,2),
		doctor_fees DECIMAL(10,2),
		other_charges DECIMAL(10,2),
		total_amount DECIMAL(10,2),
		discount DECIMAL(5,2),
		amount_paid DECIMAL(10,2),
		payment_status VARCHAR(50),
		payment_method VARCHAR(50),
		FOREIGN KEY (patient_id) REFERENCES Silver.Patient(patient_id)
	);

	--  Medical Stock Table
	CREATE TABLE Silver.MedicalStock (
		medicine_id VARCHAR(255) PRIMARY KEY,
		name VARCHAR(255),
		category VARCHAR(100),
		supplier_id VARCHAR(255),
		cost_price DECIMAL(10,2),
		unit_price DECIMAL(10,2),
		stock_quantity INT,
		expiry_date DATE,
		manufacturing_date DATE,
		reorder_level INT,
		--FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
	);
	
	--  Medical Test Table
	CREATE TABLE Silver.MedicalTest (
		test_id VARCHAR(255) PRIMARY KEY,
		test_name VARCHAR(255),
		category VARCHAR(100),
		department_id VARCHAR(255),
		cost DECIMAL(10,2),
		duration INT,
		fasting_required CHAR(3),
		FOREIGN KEY (department_id) REFERENCES Silver.Department(department_id)
	);

	--  Patient Test Table
	CREATE TABLE Silver.PatientTest (
		patient_test_id VARCHAR(255) PRIMARY KEY,
		patient_id VARCHAR(255),
		test_id VARCHAR(255),
		doctor_id VARCHAR(255),
		test_date DATE,
		result_date DATE,
		result_notes varchar(max),
		payment_method VARCHAR(50),
		amount DECIMAL(10,2),
		discount DECIMAL(5,2),
		FOREIGN KEY (patient_id) REFERENCES Silver.Patient(patient_id),
		FOREIGN KEY (test_id) REFERENCES Silver.MedicalTest(test_id),
		FOREIGN KEY (doctor_id) REFERENCES Silver.Doctor(doctor_id)
	);

	--  Satisfaction Score Table
	CREATE TABLE Silver.SatisfactionScore (
		satisfaction_id varchar(255) PRIMARY KEY,
		patient_id VARCHAR(255),
		doctor_id varchar(255),
		rating INT,
		feedback varchar(max),
		date DATE,
		department_id varchar(255),
		FOREIGN KEY (doctor_id) REFERENCES Silver.Doctor(doctor_id),
		FOREIGN KEY (patient_id) REFERENCES Silver.Patient(patient_id),
		FOREIGN KEY (department_id) REFERENCES Silver.Department(department_id)
	);

	--  Staff Table
	CREATE TABLE Silver.Staff (
		staff_id VARCHAR(255) PRIMARY KEY,
		name VARCHAR(255),
		department_id VARCHAR(255),
		role VARCHAR(100),
		salary DECIMAL(10,2),
		joining_date DATE,
		shift VARCHAR(50),
		phone VARCHAR(20),
		email VARCHAR(255),
		address varchar(max),
		FOREIGN KEY (department_id) REFERENCES Silver.Department(department_id)
	);

	--  Supplier Table
	CREATE TABLE Silver.Supplier (
		supplier_id VARCHAR(255) PRIMARY KEY,
		name VARCHAR(255),
		contact_person VARCHAR(255),
		phone VARCHAR(20),
		email VARCHAR(255),
		address varchar(max),
		city varchar(max),
		landmark VARCHAR(255),
		pincode int  , 
		state VARCHAR(255),
		contract_start DATE,
		contract_end DATE
	);

	ALTER TABLE Silver.MedicalStock
ADD CONSTRAINT FK_MedicalStock_Supplier
FOREIGN KEY (supplier_id) REFERENCES Silver.Supplier(supplier_id);



-- medicine_patient missin
CREATE TABLE Silver.medicine_patient (
		patient_id VARCHAR(255) PRIMARY KEY,
		medicine VARCHAR(255),
		Quantity INT,
		purchase_date Date
		FOREIGN KEY (patient_id) REFERENCES Silver.Patient(patient_id)
	);
