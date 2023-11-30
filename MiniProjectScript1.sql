DROP DATABASE IF EXISTS `Suwapiyasa_system`;

CREATE DATABASE `Suwapiyasa_system`;

USE `Suwapiyasa_system`;

 CREATE TABLE WorkingStaffAddress (
  StaffID VARCHAR(20) PRIMARY KEY,
  Address VARCHAR(250) NOT NULL
);

CREATE TABLE PatientBloodType (
  PatientID VARCHAR(20) PRIMARY KEY,
  BloodType VARCHAR(15) NOT NULL
);

drop table PatientBloodType;
CREATE TABLE `WorkingStaff` (
  `employee_number`  VARCHAR(20) PRIMARY KEY,
  `name` VARCHAR(200) NOT NULL,
  `gender` VARCHAR(10),
  `address` VARCHAR(250),
  `telephone_number` VARCHAR(10)
);

CREATE TABLE `Medication` (
  `code` VARCHAR(20) PRIMARY KEY,
  `name` VARCHAR(200) NOT NULL,
  `quantity_on_hand` INT NOT NULL,
  `quantity_ordered` INT NOT NULL,
  `cost` DECIMAL(10, 2) NOT NULL,
  `expiration_date` DATE NOT NULL
);

CREATE TABLE `Patient` (
  `patient_id_number`  VARCHAR(20) PRIMARY KEY,
  `Initials` VARCHAR(50) NOT NULL,
  `Surname` VARCHAR(250) NOT NULL,
  `Allergy` VARCHAR(250) NOT NULL,
  `Blood_type` VARCHAR(15) NOT NULL
);

CREATE TABLE `Location` (
  `location_id`  VARCHAR(20) PRIMARY KEY,
  `room_number` VARCHAR(20) NOT NULL,
  `bed_number` VARCHAR(20) NOT NULL,
  `nursing_unit`  VARCHAR(20) NOT NULL
); 

CREATE TABLE `Surgery` (
  `surgery_id` VARCHAR(20) PRIMARY KEY ,
  `category` VARCHAR(100) NOT NULL,
  `special_needs` VARCHAR(300) NOT NULL,
  `surgery_name` VARCHAR(200) NOT NULL,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `patient_id_number` VARCHAR(20),
  FOREIGN KEY (`patient_id_number`) REFERENCES `Patient`(`patient_id_number`)
);

CREATE TABLE `Nurse` (
  `nurse_id` VARCHAR(20) PRIMARY KEY,
  `grade` VARCHAR(10) NOT NULL,
  `skill_type` VARCHAR(200) NOT NULL,
  `years_of_experience` INT NOT NULL
);
CREATE TABLE `Doctor` (
  `doctor_id`  VARCHAR(20) PRIMARY KEY,
  `name` VARCHAR(200) NOT NULL,
  `specialty` VARCHAR(250) NOT NULL
);

CREATE TABLE `HeadDoctor` (
  `hd_number`  VARCHAR(20) PRIMARY KEY,
  `doctor_id`  VARCHAR(20) NOT NULL,
  FOREIGN KEY (`doctor_id`) REFERENCES `Doctor`(`doctor_id`)
);

CREATE TABLE `PrimaryCareDoctor` (
  `doctor_id` VARCHAR(20),
  `patient_id_number` VARCHAR(20),
  PRIMARY KEY (`doctor_id`, `patient_id_number`),
  FOREIGN KEY (`doctor_id`) REFERENCES `Doctor`(`doctor_id`),
  FOREIGN KEY (`patient_id_number`) REFERENCES `Patient`(`patient_id_number`)
);

CREATE TABLE `Surgeon` (
  `surgeon_id`  VARCHAR(20) PRIMARY KEY,
  `specialty` VARCHAR(300) NOT NULL,
  `length_of_contract` INT NOT NULL,
  `type_of_contract` VARCHAR(200) NOT NULL
);

CREATE TABLE `Assigned_Surgeon_for_Surgery` (
  `surgeon_id`  VARCHAR(20),
  `surgery_id`  VARCHAR(20),
  FOREIGN KEY (`surgeon_id`) REFERENCES `Surgeon`(`surgeon_id`),
  FOREIGN KEY (`surgery_id`) REFERENCES `Surgery`(`surgery_id`),
  PRIMARY KEY (`surgeon_id`, `surgery_id`)
);

CREATE TABLE `Assigned_Patient_Location` (
  `patient_id_number`  VARCHAR(20),
  `location_id`  VARCHAR(20),
  FOREIGN KEY (`patient_id_number`) REFERENCES `Patient`(`patient_id_number`),
  FOREIGN KEY (`location_id`) REFERENCES `Location`(`location_id`),
  PRIMARY KEY (`patient_id_number`, `location_id`)
);

CREATE TABLE `Assigned_Nurse_for_Surgery` (
  `surgery_id`  VARCHAR(20),
  `nurse_id` VARCHAR(20),
  FOREIGN KEY (`surgery_id`) REFERENCES `Surgery`(`surgery_id`),
  FOREIGN KEY (`nurse_id`) REFERENCES `Nurse`(`nurse_id`),
  PRIMARY KEY (`surgery_id`, `nurse_id`)
);
CREATE TABLE `Salary` (
  `employee_number` VARCHAR(20) PRIMARY KEY,
  `monthly_salary` DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (`employee_number`) REFERENCES `WorkingStaff`(`employee_number`)
);

CREATE TABLE `PatientMedicationAllocation` (
  `patient_id_number` VARCHAR(20) NOT NULL,
  `code` VARCHAR(200) NOT NULL,
  `allocation_date` DATE NOT NULL,
  `quantity_allocated` INT NOT NULL,
  FOREIGN KEY (`patient_id_number`) REFERENCES Patient(`patient_id_number`),
  FOREIGN KEY (`code`) REFERENCES Medication(`code`)
);






INSERT INTO `WorkingStaff` (employee_number,name,address, telephone_number, gender)
VALUES 
 ('Emp38394','A.A.Samaraweera','42 Maradana Road', '0714245334', 'Male'), 
 ('Emp38097','D.L.Rnathunga','68 bandaranayake road, Colombo', '0714245354', 'Female'), 
 ('Emp38761','S.D.F.Ranasinghe','233 uyana Road', '0726245334', 'Female'),
 ('Emp38002','O.K.Fathima','Loak road, Galle', '0776525354', 'Female'), 
 ('Emp38774','H.H.Fernando','Colombo Road', '0714240965', 'Male'), 
 ('Emp38310','H.S.Pathirana','Main street Ratnapura', '0716520954', 'Male'), 
 ('Emp38925','L.Kumara','3 road Gampaha', '0726247100', 'Female'),
 ('Emp38976','A.Perera','345 bandaranayake road, Kandy', '071499954', 'Female'), 
 ('Emp38444','P.Rajapakshe','45 uyana Road, Colombo', '0726245213', 'Female'),
 ('Emp38223','G.R.Bandara','High level road, Gampaha', '0716520954', 'Male');
 
INSERT INTO Medication (code, name, quantity_on_hand, quantity_ordered, cost, expiration_date) 
VALUES 
 ('E1001', 'injection SDH98', 24, 50, 10030.00, '2023-10-01'),
 ('E1002', 'Drop JF3', 11, 41, 26434.88, '2023-09-28'),  
 ('E1003', 'Tablet AC34', 53, 100, 1500.99, '2025-12-31'),
 ('E1004', 'Syrup XYZ45', 35, 25, 875.50, '2023-09-04'),
 ('E1005', 'Injection FGH12', 18, 60, 320.75, '2023-09-20'), 
 ('E1006', 'Tablet PQR78', 42, 80, 750.25, '2025-09-25'), 
 ('E1007', 'Gel OPL65', 29, 45, 450.80, '2023-11-15'), 
 ('E1008', 'Injection RST23', 20, 30, 1500.00, '2025-08-03');

 
INSERT INTO Patient (patient_id_number, Initials, Surname, Allergy, Blood_type) 
VALUES 
('PID2020', 'P','Perera', 'naproxen', 'O+'), 
('PID2021', 'L.K','Fernando', 'Penicillin', 'AB-'), 
('PID2022', 'P','Gunawathi', 'Amoxicillin', 'A+'),
('PID2023', 'J','Jinadasa', 'Codeine', 'B+'),
('PID2024', 'L.P.D.F','Ariyawathi', 'Codeine', 'O-'),
('PID2025', 'W.A.S ','Mohommad', 'lidocaine', 'AB+'),
('PID2026', 'L.G','Ramesha', 'naproxen', 'O-'),
('PID2027', 'H.D.S.V.B.C','Manike', 'Amoxicillin', 'A+');

INSERT INTO Location (location_id, room_number,bed_number, nursing_unit)
VALUES 
 ('L93', 'R10132', 'BR101653', 'Unit5'),
 ('L91', 'R10143', 'BR101454', 'Unit8'),
 ('L42', 'R10177', 'BR101756', 'Unit3'),
 ('L51', 'R10199', 'BR101898', 'Unit2'),
 ('L90', 'R10210', 'BR102021', 'Unit7'),
 ('L88', 'R10322', 'BR103211', 'Unit3');
 
INSERT INTO Surgery (surgery_id,category, special_needs, surgery_name, patient_id_number, date, time) 
VALUES 
('S9232','Cardiac', 'have to be monitored', 'Heart Valve Surgery', 'PID2024', '2023-09-30', '09:00:00'), 
('S3455','Neurological', 'Requires specialized equipment', 'Neurosurgery', 'PID2021', '2023-09-30', '14:30:00'), 
('S5756','Orthopedic', '-', 'Orthopedic Surgery', 'PID2027', '2023-10-10', '11:45:00'),
('S7433','Cardiac', 'Requires post-operative medication', 'Cardiac Surgery', 'PID2026', '2024-01-05', '08:15:00'),
('S6277','Neurological', '-', 'Neurosurgery', 'PID2025', '2024-03-20', '10:00:00'),
('S0599','Orthopedic', 'require physical therapy afterwards', 'Orthopedic Surgery','PID2023', '2023-09-30', '13:30:00'),
('S2345','Cardiac', '-', 'Cardiac Surgery', 'PID2022', '2024-04-12', '15:45:00'),
('S9032','Neurological', 'Requires specialized equipment', 'Neurosurgery', 'PID2020', '2024-06-28', '11:00:00');
 
 INSERT INTO Nurse (nurse_id, grade, skill_type, years_of_experience)
 VALUES 
 ('NID10239', 'Junior', 'Emergency', 2), 
 ('NID10238', 'Junior', 'Pediatrics', 2),
 ('NID10103', 'Senior', 'ICU',12),
 ('NID10240', 'Junior', 'Emergency', 2),
 ('NID10156', 'Senior', 'ICU', 7),
 ('NID10290', 'Junior', 'Pediatrics', 1),
 ('NID10175', 'Senior', 'ICU', 12),
 ('NID10276', 'Junior', 'Neurology', 1);
 
 INSERT INTO Doctor (doctor_id, name, specialty) 
 VALUES 
 ('DID30023', 'Dr. Abeywickrama', 'Pediatrician'), 
 ('DID30433', 'Dr. D.Sugath', 'Neurology'),
 ('DID30100', 'Dr. Lanera', 'Orthopedics'),
 ('DID30678', 'Dr. W.R.Nilangaha', 'Cardiology'),
 ('DID30890', 'Dr. Kapudasa', 'Oncology'),
 ('DID30321', 'Dr. Rashmi Wanasundara', 'Neurology'),
 ('DID30987', 'Dr. R.P.Perera', 'Cardiology'),
 ('DID31001', 'Dr. U.I.Aluvihare', 'Cardiology');
 
 INSERT INTO HeadDoctor (hd_number, doctor_id) VALUES 
('HD2832', 'DID30678'), 
('HD2899', 'DID31001'), 
('HD2801', 'DID30433');

INSERT INTO PrimaryCareDoctor (doctor_id, patient_id_number) VALUES
 ('DID30023', 'PID2022'), 
 ('DID30321', 'PID2024'), 
 ('DID31001', 'PID2020'), 
 ('DID30100', 'PID2027'), 
 ('DID30890', 'PID2025'), 
 ('DID30433', 'PID2023'), 
 ('DID30987', 'PID2021'), 
 ('DID30678', 'PID2026');

INSERT INTO Surgeon (surgeon_id, specialty, length_of_contract, type_of_contract) VALUES 
('SID2020', 'Cardiothoracic Surgeon', 3, 'Permanent'), 
('SID2021', 'Neurosurgeon', 2, 'Temporary'), 
('SID2022', 'Orthopedic Surgeon', 4, 'Permanent'), 
('SID2023', 'Neurosurgeon', 3, 'Temporary'), 
('SID2024', 'Neurosurgeon Surgeon', 5, 'Permanent'), 
('SID2025', 'General Surgeon', 2, 'Permanent'),
('SID2026', 'ENT Surgeon', 1, 'Temporary'),
('SID2027', 'Cardiothoracic Surgeon', 3, 'Temporary');


INSERT INTO Assigned_Surgeon_for_Surgery (surgeon_id, surgery_id) VALUES 
('SID2020', 'S9232'),
('SID2021', 'S3455'), 
('SID2022', 'S5756'), 
('SID2023', 'S7433'), 
('SID2024', 'S6277'), 
('SID2025', 'S0599'), 
('SID2026', 'S2345'), 
('SID2027', 'S9032');

INSERT INTO Assigned_Patient_Location (patient_id_number, location_id) VALUES 
('PID2020', 'L93'), 
('PID2021', 'L91'), 
('PID2022', 'L42'), 
('PID2023', 'L51'), 
('PID2024', 'L90'), 
('PID2025', 'L88'), 
('PID2026', 'L93'), 
('PID2027', 'L91');

INSERT INTO Assigned_Nurse_for_Surgery (surgery_id, nurse_id) VALUES 
('S9232', 'NID10239'), 
('S6277', 'NID10238'), 
('S5756', 'NID10103'), 
('S5756', 'NID10240'), 
('S6277', 'NID10156'), 
('S0599', 'NID10290'), 
('S0599', 'NID10175'), 
('S9032', 'NID10276');

INSERT INTO Salary (employee_number, monthly_salary) VALUES
 ('Emp38394', 50000.00), 
 ('Emp38097', 55000.00), 
 ('Emp38761', 45000.00), 
 ('Emp38002', 60000.00), 
 ('Emp38774', 55000.00), 
 ('Emp38310', 60000.00), 
 ('Emp38925', 50000.00), 
 ('Emp38976', 45000.00), 
 ('Emp38444', 55000.00), 
 ('Emp38223', 60000.00);
 
 
INSERT INTO PatientMedicationAllocation (patient_id_number, code, allocation_date, quantity_allocated)
VALUES
  ('PID2020', 'E1001', '2023-09-05', 2),
  ('PID2021', 'E1002', '2023-09-06', 1),
  ('PID2022', 'E1003', '2023-09-07', 3),
  ('PID2023', 'E1004', '2023-09-08', 2),
  ('PID2024', 'E1005', '2023-09-09', 1),
  ('PID2025', 'E1006', '2023-09-10', 2),
  ('PID2026', 'E1007', '2023-09-11', 2),
  ('PID2021', 'E1008', '2023-09-12', 1),
  ('PID2020', 'E1001', '2023-09-13', 3),
  ('PID2021', 'E1002', '2023-09-14', 2),
  ('PID2022', 'E1003', '2023-09-15', 1),
  ('PID2022', 'E1004', '2023-09-16', 3),
  ('PID2024', 'E1005', '2023-09-17', 2),
  ('PID2025', 'E1006', '2023-09-18', 1),
  ('PID2026', 'E1007', '2023-09-19', 2),
  ('PID2025', 'E1008', '2023-09-20', 3);
  


