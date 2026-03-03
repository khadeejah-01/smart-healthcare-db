-- =============================================
-- SECURITY ROLES - MYSQL
-- =============================================

-- Create doctor user (can read all, write to clinical tables only)
CREATE USER IF NOT EXISTS 'doctor_user'@'localhost' IDENTIFIED BY 'doctor123';
GRANT SELECT ON healthcare.* TO 'doctor_user'@'localhost';
GRANT INSERT, UPDATE ON healthcare.medical_records TO 'doctor_user'@'localhost';
GRANT INSERT, UPDATE ON healthcare.prescriptions TO 'doctor_user'@'localhost';

-- Create admin user (full access)
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON healthcare.* TO 'admin_user'@'localhost';

-- Verify users created
SELECT User, Host FROM mysql.user WHERE User IN ('doctor_user', 'admin_user');
