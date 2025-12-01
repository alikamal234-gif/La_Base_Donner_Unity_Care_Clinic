-- CREAT LES TABLEAUX DE BASE DE DONNER 

CREATE TABLE patients(
	patient_id int(11) PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    gender ENUM('Male','Female','Other') NOT null,
    date_of_birth date NOT NULL,
    phone_number varchar(15),
    email varchar(100),
    address varchar(255)
);
CREATE TABLE medications(
	medication_id int(11) PRIMARY KEY AUTO_INCREMENT,
    medication_name varchar(100) NOT NULL,
    dosage varchar(50)
);
CREATE TABLE departments(
	department_id int(11) PRIMARY KEY AUTO_INCREMENT,
    department_name varchar(50) NOT NULL,
    location varchar(100)
);
CREATE TABLE doctors(
	doctor_id int(11) PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    specialization varchar(50) NOT NULL,
    phone_number varchar(15),
    email varchar(100),
    department_id int(11),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE prescriptions(
	prescription_id int(11) PRIMARY KEY AUTO_INCREMENT,
    patient_id int(11),
    doctor_id int(11),
    medication_id int(11),
    prescription_date date,
    dosage_instructions varchar(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rooms(
    room_id int(11) PRIMARY KEY AUTO_INCREMENT,
    room_number varchar(10),
    room_type ENUM('General','Private','ICU'),
    availability tinyint(1)
);

CREATE TABLE appointments(
	appointment_id int(11) PRIMARY KEY AUTO_INCREMENT,
    appointment_date date NOT NULL,
    appointment_time time NOT NULL,
    doctor_id int(11),
    patient_id int(11),
    reason varchar(255),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE admissions(
	admission_id int(11) PRIMARY KEY AUTO_INCREMENT,
    patient_id int(11),
    room_id int(11),
    admission_date date NOT NULL,
    discharge_date date,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE staff(
    staff_id int(11) PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    job_title varchar(50) NOT NULL,
    phone_number varchar(15),
    email varchar(100),
    department_id int(11),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- INSERT INTO LES TABLEAU DE BASE DE DONNER 


-- creat des fake data pour le tableau de departments
INSERT INTO departments (department_name, location) VALUES
('Cardiology', 'Building A, Floor 3'),
('Pediatrics', 'Building B, Floor 1'),
('Orthopedics', 'Building A, Floor 2'),
('Neurology', 'Building C, Floor 4'),
('Emergency', 'Main Building, Ground Floor');

-- creat des fake data pour le tableau de rooms
INSERT INTO rooms (room_number, room_type, availability) VALUES
('101', 'General', 1),
('102', 'General', 0),
('201', 'Private', 1),
('202', 'Private', 0),
('301', 'ICU', 1),
('302', 'ICU', 0),
('103', 'General', 1),
('203', 'Private', 1),
('303', 'ICU', 1),
('104', 'General', 0);

-- creat des fake data pour le tableau de patients
INSERT INTO patients (first_name, last_name, gender, date_of_birth, phone_number, email, address) VALUES
('Ahmed', 'Alami', 'Male', '1985-03-15', '0612345678', 'ahmed.alami@email.com', '123 Rue Mohamed V, Casablanca'),
('Fatima', 'Zahra', 'Female', '1992-07-22', '0623456789', 'fatima.zahra@email.com', '45 Avenue Hassan II, Rabat'),
('Youssef', 'Benani', 'Male', '1978-11-30', '0634567890', 'youssef.benani@email.com', '78 Rue des Orangers, Marrakech'),
('Samira', 'Khalil', 'Female', '1965-05-14', '0645678901', 'samira.khalil@email.com', '12 Boulevard Mohamed VI, Fes'),
('Karim', 'Mourad', 'Male', '2000-01-10', '0656789012', 'karim.mourad@email.com', '34 Avenue des FAR, Tangier');

-- creat des fake data pour le tableau de doctors
INSERT INTO doctors (first_name, last_name, specialization, phone_number, email, department_id) VALUES
('Driss', 'Benjelloun', 'Cardiologist', '0667890123', 'driss.benjelloun@hospital.com', 1),
('Leila', 'Mansouri', 'Pediatrician', '0678901234', 'leila.mansouri@hospital.com', 2),
('Omar', 'Tazi', 'Orthopedic Surgeon', '0689012345', 'omar.tazi@hospital.com', 3),
('Nadia', 'El Fassi', 'Neurologist', '0690123456', 'nadia.elfassi@hospital.com', 4),
('Hassan', 'Cherkaoui', 'Emergency Physician', '0601234567', 'hassan.cherkaoui@hospital.com', 5);

-- creat des fake data pour le tableau de staff
INSERT INTO staff (first_name, last_name, job_title, phone_number, email, department_id) VALUES
('Khadija', 'Bouazza', 'Nurse', '0611122233', 'khadija.bouazza@hospital.com', 1),
('Mohamed', 'Rahmani', 'Administrator', '0622233344', 'mohamed.rahmani@hospital.com', NULL),
('Amina', 'Saidi', 'Receptionist', '0633344455', 'amina.saidi@hospital.com', NULL),
('Rachid', 'Bouhlal', 'Lab Technician', '0644455566', 'rachid.bouhlal@hospital.com', 4),
('Salma', 'El Amrani', 'Pharmacist', '0655566677', 'salma.elamrani@hospital.com', NULL);

-- creat des fake data pour le tableau de admissions
INSERT INTO admissions (patient_id, room_id, admission_date, discharge_date) VALUES
(1, 3, '2024-01-15', '2024-01-20'),
(2, 5, '2024-01-18', NULL),
(3, 2, '2024-01-10', '2024-01-12'),
(4, 1, '2024-01-20', NULL),
(5, 4, '2024-01-05', '2024-01-08');

-- creat des fake data pour le tableau de appointments
INSERT INTO appointments (appointment_date, appointment_time, doctor_id, patient_id, reason) VALUES
('2024-02-01', '09:00:00', 1, 1, 'Heart checkup'),
('2024-02-01', '10:30:00', 2, 2, 'Child vaccination'),
('2024-01-25', '14:00:00', 3, 3, 'Knee pain follow-up'),
('2024-02-02', '11:00:00', 4, 4, 'Headache consultation'),
('2024-01-28', '16:00:00', 5, 5, 'Emergency follow-up');

-- creat des fake data pour le tableau de medications
INSERT INTO medications (medication_name, dosage) VALUES
('Paracetamol', '500mg'),
('Amoxicillin', '250mg'),
('Ibuprofen', '400mg'),
('Atorvastatin', '20mg'),
('Metformin', '850mg');

-- creat des fake data pour le tableau de prescriptions
INSERT INTO prescriptions (patient_id, doctor_id, medication_id, prescription_date, dosage_instructions) VALUES
(1, 1, 1, '2024-01-16', 'Take 1 tablet every 8 hours for 5 days'),
(2, 2, 2, '2024-01-19', 'Take 1 capsule every 12 hours for 7 days'),
(3, 3, 3, '2024-01-11', 'Take 1 tablet when needed for pain'),
(4, 4, 4, '2024-01-21', 'Take 1 tablet daily at bedtime'),
(5, 5, 5, '2024-01-06', 'Take 1 tablet twice daily with meals');



