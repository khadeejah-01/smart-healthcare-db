-- =============================================
-- PATIENT HISTORY VIEW - MYSQL
-- =============================================

CREATE VIEW patient_complete_history AS
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) as patient_name,
    TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) as age,
    p.gender,
    p.blood_group,
    p.contact_phone,
    mr.visit_date,
    CONCAT(d.first_name, ' ', d.last_name) as doctor_name,
    d.specialization,
    icd.code as diagnosis_code,
    icd.description as diagnosis,
    mr.symptoms,
    mr.doctor_notes,
    mr.treatment
FROM patients p
LEFT JOIN medical_records mr ON p.patient_id = mr.patient_id
LEFT JOIN doctors d ON mr.doctor_id = d.doctor_id
LEFT JOIN icd_codes icd ON mr.diagnosis_code = icd.code
ORDER BY p.patient_id, mr.visit_date DESC;

-- Test the view
SELECT * FROM patient_complete_history WHERE patient_id = 1;
