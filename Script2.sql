USE `Suwapiyasa_system`;

CREATE VIEW ListofSurgeries AS
SELECT patient.patient_id_number AS Patient_ID,
CONCAT(patient.Initials, ' ', patient.Surname) AS Patient_Name,
CONCAT(location.bed_number, '  ', location.room_number) AS Location,
surgery.surgery_name AS Surgery_Name,
surgery.date AS Surgery_Date
FROM Patient 
JOIN Assigned_Patient_Location apl ON patient.patient_id_number = apl.patient_id_number
JOIN Location ON apl.location_id = location.location_id
JOIN Surgery  ON patient.patient_id_number = surgery.patient_id_number;
/* 
 Table Creation
*/

CREATE TABLE `MedInfo` (
  `MedName` VARCHAR(20) NOT NULL ,
  `QuantityAvailable` INT NOT NULL,
  `ExpirationDate` DATE NOT NULL      
);
-- Trigger
  DELIMITER ;;
CREATE TRIGGER `InsertMedInfo` AFTER INSERT ON `Medication` FOR EACH ROW BEGIN
    INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
        VALUES (new.name, new.quantity_on_hand, new.expiration_date);
  END;;

DELIMITER ;; 
CREATE TRIGGER `UpdateMedInfo` AFTER UPDATE ON `Medication` FOR EACH ROW BEGIN
    IF (old.name != new.name) OR (old.quantity_on_hand != new.quantity_on_hand) OR (old.expiration_date != new.expiration_date)
    THEN
        UPDATE MedInfo
            SET MedName=new.name,
                QuantityAvailable=new.quantity_on_hand,
                ExpirationDate=new.expiration_date
        WHERE MedName=old.name;
    END IF;
  END;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER `deleteMedInfo` AFTER DELETE ON `Medication` FOR EACH ROW BEGIN
    DELETE FROM MedInfo WHERE MedName = old.name;
  END;;

DELIMITER //
CREATE PROCEDURE number_ofMedications_taken_by_a_patient(INOUT Medication_count INT, IN param_patient_id_number VARCHAR(20))
BEGIN
    SELECT count(code) INTO Medication_count FROM PatientMedicationAllocation WHERE patient_id_number = param_patient_id_number;
END //
DELIMITER ;
CALL number_ofMedications_taken_by_a_patient(@Medication_count,'PID2025');

SELECT @Medication_count AS  medications_count_of_a_patient;

drop procedure number_ofMedications_taken_by_a_patient;


DELIMITER $$
CREATE FUNCTION expiration_of_a_medication (Med_expiration_date DATE)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE TodayDate DATE;
    DECLARE remaining_days INT;
    SET TodayDate = CURDATE();
    SET remaining_days = DATEDIFF(Med_expiration_date, TodayDate);
    RETURN remaining_days;
END$$
DELIMITER ;
SELECT code,name,quantity_on_hand,quantity_ordered,cost,expiration_of_a_medication(expiration_date) AS Med_expiration_date
FROM Medication
WHERE expiration_of_a_medication(expiration_date) < 30;


 CREATE TABLE WorkingStaffAddress (
  StaffID VARCHAR(20) PRIMARY KEY,
  Address VARCHAR(250) NOT NULL
);

CREATE TABLE PatientBloodType (
  PatientID VARCHAR(20) PRIMARY KEY,
  BloodType VARCHAR(15) NOT NULL
); 

LOAD XML 
INFILE "C:/xml/staff_address.xml"
INTO TABLE Suwapiyasa_system.WorkingStaffAddress
ROWS IDENTIFIED BY '<Staff>';

LOAD XML 
INFILE "C:/xml/patient_bloodtype.xml"
INTO TABLE Suwapiyasa_system.PatientBloodType
ROWS IDENTIFIED BY '<Patient>';

select * from PatientBloodType;
