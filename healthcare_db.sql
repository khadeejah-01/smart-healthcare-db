CREATE DATABASE healthcare;
USE healthcare;
SELECT DATABASE();

-- =============================================
-- MYSQL - CORE TABLES
-- =============================================

-- 1. PATIENTS TABLE
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    contact_phone VARCHAR(15),
    blood_group VARCHAR(5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. DOCTORS TABLE
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    license_number VARCHAR(50) UNIQUE NOT NULL,
    contact_phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. ICD-10 CODES TABLE (AI-ready standardized diagnoses)
CREATE TABLE icd_codes (
    code VARCHAR(10) PRIMARY KEY,
    description TEXT NOT NULL,
    category VARCHAR(100)
);

-- 4. MEDICAL RECORDS TABLE (clinical consultations)
CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    diagnosis_code VARCHAR(10),
    symptoms TEXT,
    doctor_notes TEXT,
    treatment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (diagnosis_code) REFERENCES icd_codes(code)
);

-- 5. PRESCRIPTIONS TABLE
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    record_id INT,
    medication_name VARCHAR(200) NOT NULL,
    dosage VARCHAR(50),
    frequency VARCHAR(100),
    prescribed_date DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (record_id) REFERENCES medical_records(record_id) ON DELETE CASCADE
);

-- 6. LAB REPORTS TABLE
CREATE TABLE lab_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    test_type VARCHAR(100) NOT NULL,
    test_date DATE NOT NULL,
    results TEXT,
    normal_range VARCHAR(100),
    lab_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- 7. AUDIT LOG TABLE (cybersecurity feature)
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    table_name VARCHAR(50),
    action VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX idx_patients_name ON patients(last_name, first_name);
CREATE INDEX idx_medical_records_patient ON medical_records(patient_id);
CREATE INDEX idx_medical_records_date ON medical_records(visit_date);
CREATE INDEX idx_prescriptions_patient ON prescriptions(patient_id);

-- Verify all tables created
SHOW TABLES;

-- =============================================
-- SAMPLE DATA - MYSQL
-- =============================================

-- Insert ICD-10 codes (standardized for AI)
INSERT INTO icd_codes (code, description, category) VALUES
('J18.9', 'Pneumonia, unspecified organism', 'Respiratory'),
('E11.9', 'Type 2 diabetes mellitus without complications', 'Endocrine'),
('I10', 'Essential (primary) hypertension', 'Cardiovascular'),
('R50.9', 'Fever, unspecified', 'Symptoms'),
('R05', 'Cough', 'Symptoms'),
('I25.1', 'Atherosclerotic heart disease', 'Cardiovascular'),
('N18.3', 'Chronic kidney disease, stage 3', 'Renal'),
('A09', 'Infectious gastroenteritis', 'Infectious'),
('J44.0', 'COPD with acute lower respiratory infection', 'Respiratory'),
('R51', 'Headache', 'Symptoms');

-- Insert doctors
INSERT INTO doctors (first_name, last_name, specialization, license_number, contact_phone) VALUES
('Sarah', 'Ahmed', 'Pulmonology', 'PMC-12345', '03001111111'),
('Ali', 'Hassan', 'Cardiology', 'PMC-12346', '03002222222'),
('Fatima', 'Khan', 'General Medicine', 'PMC-12347', '03003333333');

-- Insert patients
INSERT INTO patients (first_name, last_name, date_of_birth, gender, contact_phone, blood_group) VALUES
('Ahmed', 'Ali', '1985-05-15', 'Male', '03101111111', 'B+'),
('Aisha', 'Malik', '1990-08-22', 'Female', '03102222222', 'O+'),
('Hassan', 'Raza', '1978-12-10', 'Male', '03103333333', 'A+'),
('Fatima', 'Zahra', '2000-03-18', 'Female', '03104444444', 'AB+');

-- Insert medical records
INSERT INTO medical_records (patient_id, doctor_id, visit_date, diagnosis_code, symptoms, doctor_notes, treatment) VALUES
(1, 1, '2025-12-10', 'J18.9', 
 'High fever (102F), persistent cough with yellow sputum, chest pain',
 'Patient presents with pneumonia symptoms. Chest X-ray shows right lower lobe infiltrate. Started on antibiotics.',
 'Augmentin 625mg TDS x 7 days, rest, plenty of fluids'),

(2, 3, '2025-12-12', 'E11.9',
 'Fatigue, increased thirst, frequent urination',
 'Known diabetic patient. HbA1c 7.2% - fair control. Counseled on diet and exercise.',
 'Continue Metformin 500mg BD, dietary modifications'),

(3, 2, '2025-12-14', 'I10',
 'Headache, dizziness, no visual changes',
 'New diagnosis of hypertension. BP 165/100. No end-organ damage. Started antihypertensive.',
 'Amlodipine 5mg OD, lifestyle modifications, follow-up in 2 weeks'),

(4, 3, '2025-12-15', 'R50.9',
 'Fever, body aches, sore throat',
 'Viral upper respiratory infection. Throat mildly erythematous. No bacterial features.',
 'Paracetamol PRN, rest, fluids. Return if fever persists >3 days');

-- Insert prescriptions
INSERT INTO prescriptions (patient_id, doctor_id, record_id, medication_name, dosage, frequency, prescribed_date) VALUES
(1, 1, 1, 'Augmentin', '625mg', 'Three times daily', '2025-12-10'),
(1, 1, 1, 'Paracetamol', '500mg', 'As needed for fever', '2025-12-10'),
(2, 3, 2, 'Metformin', '500mg', 'Twice daily with meals', '2025-12-12'),
(3, 2, 3, 'Amlodipine', '5mg', 'Once daily in morning', '2025-12-14'),
(4, 3, 4, 'Paracetamol', '500mg', 'Three times daily', '2025-12-15');

-- Insert lab reports
INSERT INTO lab_reports (patient_id, test_type, test_date, results, normal_range, lab_name) VALUES
(1, 'Complete Blood Count', '2025-12-10', 
 'WBC: 15,200 cells/mcL (Elevated - indicates infection)', 
 'WBC: 4,000-11,000 cells/mcL', 'City Hospital Lab'),

(1, 'Chest X-ray', '2025-12-10', 
 'Right lower lobe infiltrate consistent with pneumonia. No effusion.', 
 'N/A', 'Radiology Department'),

(2, 'HbA1c', '2025-12-12', 
 'HbA1c: 7.2% (Fair diabetic control)', 
 'Normal: <5.7%, Target for diabetics: <7.0%', 'PathLab'),

(3, 'Lipid Profile', '2025-12-14', 
 'Total Cholesterol: 210 mg/dL, LDL: 135 mg/dL (Borderline high)', 
 'Total Cholesterol: <200 mg/dL, LDL: <100 mg/dL', 'Chughtai Lab');

-- Verify data inserted
SELECT 'Patients' as table_name, COUNT(*) as count FROM patients
UNION ALL SELECT 'Doctors', COUNT(*) FROM doctors
UNION ALL SELECT 'ICD Codes', COUNT(*) FROM icd_codes
UNION ALL SELECT 'Medical Records', COUNT(*) FROM medical_records
UNION ALL SELECT 'Prescriptions', COUNT(*) FROM prescriptions
UNION ALL SELECT 'Lab Reports', COUNT(*) FROM lab_reports;
