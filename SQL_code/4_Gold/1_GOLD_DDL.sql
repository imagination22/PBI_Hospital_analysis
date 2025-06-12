CREATE TABLE GOLD.Dim_Patient (
    patient_key INT PRIMARY KEY,
    patient_id VARCHAR(255) UNIQUE,
    name VARCHAR(255),
    gender VARCHAR(10),
    age INT,
    blood_group VARCHAR(10),
    state VARCHAR(50),
    admission_status VARCHAR(50)
);
CREATE TABLE GOLD.Dim_Doctor (
    doctor_key INT PRIMARY KEY,
    doctor_id VARCHAR(255) UNIQUE,
    name VARCHAR(255),
    specialization VARCHAR(100),
    experience_years INT,
    availability VARCHAR(50)  
);
CREATE TABLE GOLD.Dim_PaymentMethod (
    payment_method_key INT PRIMARY KEY,
    method_name VARCHAR(50) UNIQUE  -- Cash, Credit Card, Insurance, Online, etc.
);
CREATE TABLE GOLD.Dim_Department (
    department_key INT PRIMARY KEY,
    department_id VARCHAR(255) UNIQUE,
    name VARCHAR(255),
    total_staff INT
);
CREATE TABLE GOLD.Dim_Room (
    room_key INT PRIMARY KEY,
    room_id VARCHAR(255) UNIQUE,
    room_type VARCHAR(50),
    capacity INT,
    daily_charges DECIMAL(10,2)
);
CREATE TABLE GOLD.Dim_Test (
    test_key INT PRIMARY KEY,
    test_id VARCHAR(255) UNIQUE,
    test_name VARCHAR(255),
    category VARCHAR(100),
    cost DECIMAL(10,2)
);
CREATE TABLE GOLD.Dim_Medicine (
    medicine_key INT PRIMARY KEY,
    medicine_id VARCHAR(255) UNIQUE,
    name VARCHAR(255),
    category VARCHAR(100),
    cost_price DECIMAL(10,2),
    unit_price DECIMAL(10,2),
    expiry_date DATE
);
CREATE TABLE GOLD.Dim_Supplier (
    supplier_key INT PRIMARY KEY,
    supplier_id VARCHAR(255) UNIQUE,
    name VARCHAR(255),
    contact_person VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50)
);
CREATE TABLE GOLD.Dim_Date (
    date_key INT PRIMARY KEY,
    date DATE UNIQUE,
    day INT,
    month INT,
    year INT,
    quarter INT,
    weekday_name VARCHAR(50),
    is_weekend BIT
);
CREATE TABLE GOLD.Dim_Bed (
    bed_key INT PRIMARY KEY,
    bed_id VARCHAR(255) UNIQUE,
    room_key INT, -- References Dim_Room
    status VARCHAR(50), -- Available, Occupied, Maintenance
    occupation_start_time DATETIME NULL, -- When the bed was occupied
    occupation_end_time DATETIME NULL, -- When the bed was freed
    FOREIGN KEY (room_key) REFERENCES GOLD.Dim_Room(room_key)
);

CREATE TABLE GOLD.Fact_Appointments (
    appointment_id VARCHAR(255) PRIMARY KEY,
    patient_key int,
    doctor_key int,
    department_key INT,
    date_key INT,
    reason varchar(max),
    diagnosis varchar(max),
    payment_method_key INT,
    discount DECIMAL(5,2),
    fees DECIMAL(10,2),
    FOREIGN KEY (patient_key) REFERENCES GOLD.Dim_Patient(patient_key),
    FOREIGN KEY (doctor_key) REFERENCES GOLD.Dim_Doctor(doctor_key),
    FOREIGN KEY (department_key) REFERENCES GOLD.Dim_Department(department_key),
    FOREIGN KEY (date_key) REFERENCES GOLD.Dim_Date(date_key),
    FOREIGN KEY (payment_method_key) REFERENCES GOLD.Dim_PaymentMethod(payment_method_key)
);
CREATE TABLE GOLD.Fact_Billing (
    bill_id VARCHAR(255) PRIMARY KEY,
    patient_key INT,
    admission_date_key INT,
    discharge_date_key INT,
    room_charges DECIMAL(10,2),
    surgery_charges DECIMAL(10,2),
    medicine_charges DECIMAL(10,2),
    test_charges DECIMAL(10,2),
    doctor_fees DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    discount DECIMAL(5,2),
    amount_paid DECIMAL(10,2),
    balance_due DECIMAL(10,2),
    payment_status VARCHAR(50),
    payment_method_key INT,
    FOREIGN KEY (patient_key) REFERENCES GOLD.Dim_Patient(patient_key),
    FOREIGN KEY (admission_date_key) REFERENCES GOLD.Dim_Date(date_key),
    FOREIGN KEY (discharge_date_key) REFERENCES GOLD.Dim_Date(date_key),
    FOREIGN KEY (payment_method_key) REFERENCES GOLD.Dim_PaymentMethod(payment_method_key)
);
CREATE TABLE GOLD.Fact_PatientStay (
    stay_id VARCHAR(255) PRIMARY KEY,
    patient_key INT,
    room_key INT,
    bed_key INT,
    department_key INT,
    days_admitted INT,
    daily_charge DECIMAL(10,2),
    total_room_cost DECIMAL(10,2),
    surgery_cost DECIMAL(10,2),
    FOREIGN KEY (patient_key) REFERENCES GOLD.Dim_Patient(patient_key),
    FOREIGN KEY (room_key) REFERENCES GOLD.Dim_Room(room_key),
    FOREIGN KEY (bed_key) REFERENCES GOLD.Dim_Bed(bed_key),
    FOREIGN KEY (department_key) REFERENCES GOLD.Dim_Department(department_key)
);


CREATE TABLE GOLD.Fact_Tests (
    patient_test_id VARCHAR(255) PRIMARY KEY,
    test_key INT,
    patient_key INT,
    doctor_key INT,
    test_date_key INT,
    result_date_key INT,
    test_cost DECIMAL(10,2),
    discount DECIMAL(5,2),
    result_status VARCHAR(50),
    FOREIGN KEY (test_key) REFERENCES GOLD.Dim_Test(test_key),
    FOREIGN KEY (patient_key) REFERENCES GOLD.Dim_Patient(patient_key),
    FOREIGN KEY (doctor_key) REFERENCES GOLD.Dim_Doctor(doctor_key),
    FOREIGN KEY (test_date_key) REFERENCES GOLD.Dim_Date(date_key),
    FOREIGN KEY (result_date_key) REFERENCES GOLD.Dim_Date(date_key)
);
CREATE TABLE GOLD.Fact_MedicinePurchases (
    purchase_id VARCHAR(255) PRIMARY KEY,
    patient_key INT,
    medicine_key INT,
    supplier_key INT,
    date_key INT,
    quantity_purchased INT,
    total_cost DECIMAL(10,2),
    discount_applied DECIMAL(5,2),
    FOREIGN KEY (patient_key) REFERENCES GOLD.Dim_Patient(patient_key),
    FOREIGN KEY (medicine_key) REFERENCES GOLD.Dim_Medicine(medicine_key),
    FOREIGN KEY (supplier_key) REFERENCES GOLD.Dim_Supplier(supplier_key),
    FOREIGN KEY (date_key) REFERENCES GOLD.Dim_Date(date_key)
);
CREATE TABLE GOLD.Agg_MonthlyRevenue (
    month_key INT PRIMARY KEY,
    department_key INT,
    total_revenue DECIMAL(15,2),
    test_revenue DECIMAL(15,2),
    medicine_revenue DECIMAL(15,2),
    surgery_revenue DECIMAL(15,2),
    FOREIGN KEY (department_key) REFERENCES GOLD.Dim_Department(department_key)
);
CREATE TABLE GOLD.Agg_DoctorPerformance (
    month_key INT PRIMARY KEY,
    doctor_key INT,
    total_appointments INT,
    avg_rating DECIMAL(5,2),
    total_fees DECIMAL(15,2),
    FOREIGN KEY (doctor_key) REFERENCES GOLD.Dim_Doctor(doctor_key)
);
CREATE TABLE GOLD.Agg_BedOccupancy (
    date_key INT PRIMARY KEY,
    department_key INT,
    total_beds INT,
    occupied_beds INT,
    occupancy_rate DECIMAL(5,2),
    FOREIGN KEY (department_key) REFERENCES GOLD.Dim_Department(department_key)
);