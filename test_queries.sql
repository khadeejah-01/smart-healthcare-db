-- =============================================
-- TEST QUERIES - MYSQL
-- =============================================

-- Query 1: View all patients
SELECT patient_id, first_name, last_name, blood_group, contact_phone
FROM patients;

-- Query 2: Complete history for one patient
SELECT * FROM patient_complete_history WHERE patient_id = 1;

-- Query 3: All active prescriptions
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) as patient,
    pr.medication_name,
    pr.dosage,
    pr.frequency,
    CONCAT(d.first_name, ' ', d.last_name) as doctor
FROM prescriptions pr
JOIN patients p ON pr.patient_id = p.patient_id
JOIN doctors d ON pr.doctor_id = d.doctor_id
ORDER BY pr.prescribed_date DESC;

-- Query 4: Most common diagnoses (AI/Analytics)
SELECT 
    icd.description as diagnosis,
    COUNT(*) as frequency,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()))) as avg_patient_age
FROM medical_records mr
JOIN icd_codes icd ON mr.diagnosis_code = icd.code
JOIN patients p ON mr.patient_id = p.patient_id
GROUP BY icd.description
ORDER BY frequency DESC;

-- Query 5: Most prescribed medications
SELECT 
    medication_name,
    COUNT(*) as times_prescribed
FROM prescriptions
GROUP BY medication_name
ORDER BY times_prescribed DESC;

-- Query 6: Recent audit log (security feature)
SELECT 
    action_time,
    username,
    table_name,
    action
FROM audit_log
ORDER BY action_time DESC
LIMIT 10;

-- Query 7: Patients with specific symptom (AI/NLP ready)
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) as patient,
    mr.visit_date,
    mr.symptoms,
    icd.description as diagnosis
FROM medical_records mr
JOIN patients p ON mr.patient_id = p.patient_id
JOIN icd_codes icd ON mr.diagnosis_code = icd.code
WHERE LOWER(mr.symptoms) LIKE '%fever%'
ORDER BY mr.visit_date DESC;
