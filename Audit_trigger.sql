-- =============================================
-- AUDIT TRIGGER - MYSQL Security feature
-- =============================================

DELIMITER //

-- Trigger for INSERT
CREATE TRIGGER prescriptions_audit_insert
AFTER INSERT ON prescriptions
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (username, table_name, action)
    VALUES (USER(), 'prescriptions', 'INSERT');
END;//

-- Trigger for UPDATE
CREATE TRIGGER prescriptions_audit_update
AFTER UPDATE ON prescriptions
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (username, table_name, action)
    VALUES (USER(), 'prescriptions', 'UPDATE');
END;//

-- Trigger for DELETE
CREATE TRIGGER prescriptions_audit_delete
AFTER DELETE ON prescriptions
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (username, table_name, action)
    VALUES (USER(), 'prescriptions', 'DELETE');
END;//

DELIMITER ;

-- Test the trigger
INSERT INTO prescriptions (patient_id, doctor_id, medication_name, dosage, frequency)
VALUES (1, 1, 'Test Medication', '100mg', 'Twice daily');

-- Check audit log (should show the INSERT)
SELECT * FROM audit_log ORDER BY action_time DESC LIMIT 5;
