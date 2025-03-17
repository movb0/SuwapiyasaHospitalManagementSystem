# Suwapiyasa System Database Setup

## Overview

This SQL script sets up the database for the Suwapiyasa System, which includes tables for working staff, patients, surgeries, medications, locations, and associated relationships.

## Database Initialization

The script starts by dropping the existing `Suwapiyasa_system` database and then creates a fresh database named `Suwapiyasa_system`. The `USE Suwapiyasa_system;` command ensures that subsequent table creation and data insertion occur in the correct database.

## Table Definitions

### 1. **WorkingStaffAddress**

- Stores the address of working staff members.

### 2. **PatientBloodType** (Dropped Later)

- Stores patient blood type information.

### 3. **WorkingStaff**

- Stores details of staff members, including name, gender, address, and telephone number.

### 4. **Medication**

- Tracks medications, including stock quantities, cost, and expiration dates.

### 5. **Patient**

- Stores patient details, including initials, surname, allergies, and blood type.

### 6. **Location**

- Represents different hospital locations, including rooms, beds, and nursing units.

### 7. **Surgery**

- Maintains surgery details, including type, special needs, patient ID, date, and time.

### 8. **Nurse**

- Stores details of nurses, including their grade, skill type, and years of experience.

### 9. **Doctor**

- Stores doctor details, including their specialty.

### 10. **HeadDoctor**

- Links a doctor to their role as a head doctor.

### 11. **PrimaryCareDoctor**

- Establishes a relationship between doctors and patients.

### 12. **Surgeon**

- Stores details of surgeons, including contract type and duration.

### 13. **Assigned\_Surgeon\_for\_Surgery**

- Links surgeons to surgeries they perform.

### 14. **Assigned\_Patient\_Location**

- Assigns patients to specific locations.

### 15. **Assigned\_Nurse\_for\_Surgery**

- Assigns nurses to surgeries.

### 16. **Salary**

- Stores salary details of working staff.

### 17. **PatientMedicationAllocation**

- Tracks medication allocation to patients.

## Data Insertions

- **WorkingStaff**: Adds sample employees with details.
- **Medication**: Adds sample medications with quantities and costs.
- **Patient**: Inserts patient data, including allergies and blood types.
- **Location**: Adds room and bed assignments.
- **Surgery**: Inserts sample surgeries, linking them to patients.
- **Nurse**: Adds nurses with their grades, skills, and experience.

## Constraints & Relationships

- **Foreign Keys** ensure referential integrity between related tables.
- **Primary Keys** enforce uniqueness across records.
- **Many-to-many relationships** are handled using intermediate tables like `PrimaryCareDoctor`, `Assigned_Surgeon_for_Surgery`, and `Assigned_Nurse_for_Surgery`.
